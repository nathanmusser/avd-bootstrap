#!/bin/bash -

avd_install_path="avd"
python3_path=$(which python3)
venv_name="venv_avd"
__ScriptVersion="0.1"
__ScriptName="avd-bootstrap.sh"

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE_ON_DARK_YELLOW='\033[34;43m'
NC='\033[0m'  # No Color


if command -v apt-get &> /dev/null; then
  package_manager="apt"
elif command -v dnf &> /dev/null; then
  package_manager="dnf"
elif command -v yum &> /dev/null; then
  package_manager="yum"
fi



# Python 3.10-3.12 required for ansible-core 2.16
# See here: https://docs.ansible.com/ansible/latest/reference_appendices/release_and_maintenance.html#ansible-core-support-matrix

python3_version=$($python3_path --version 2>&1 | awk '{print $2}')
if ! echo "$python3_version" | grep -qE '^3\.10|^3\.11|^3\.12' ; then
  echo -e "${RED}Fatal: Python 3.10 - 3.12 is not installed. Please install.${NC}"
  exit 1
fi
echo -e "${GREEN}Found python version $python3_version${NC}"
mkdir -p avd
cd avd
$python3_path -m venv ${venv_name}
if [ $? -ne 0 ]; then
  echo -e "${RED}Fatal: venv creation failed. You might need to install ensurepip${NC}"
  echo -e "${YELLOW}Info: Something like ${BLUE_ON_DARK_YELLOW} ${package_manager} install python3-venv ${YELLOW} might fix the problem! Check above for more detailed output from the system"
  exit 1
fi
source venv_avd/bin/activate
python3 -m pip install ansible-core==2.16.3

ansible-galaxy collection install arista.avd:==4.5.0 -p ${venv_name}/bin
ARISTA_AVD_DIR=$(ansible-galaxy collection list arista.avd --format yaml | head -1 | cut -d: -f1)
python3 -m pip install -r ${ARISTA_AVD_DIR}/arista/avd/requirements.txt
mkdir -p examples
cd examples
ansible-playbook arista.avd.install_examples
cd single-dc-l3ls
ansible-playbook build.yml