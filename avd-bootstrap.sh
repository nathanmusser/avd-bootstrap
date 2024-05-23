#!/bin/bash
# avd-bootstrap v1.0.2
#
#
# ARG_OPTIONAL_BOOLEAN([install],[],[Install AVD, not specifying this will result in a dry run])
# ARG_OPTIONAL_SINGLE([pythonpath],[p],[The path to the python interpreter instead of the system python])
# ARG_OPTIONAL_SINGLE([installdir],[d],[The path to install avd into],[./avd])
# ARG_OPTIONAL_SINGLE([venv],[e],[The venv name to use],[venv_avd])
# ARG_OPTIONAL_SINGLE([ansibleversion],[],[The ansible version to install, be careful changing this],[2.16.7])
# ARG_OPTIONAL_SINGLE([avdversion],[],[The avd version to install, be careful changing this],[4.7.1])
# ARG_OPTIONAL_BOOLEAN([avdexamples],[],[Copy AVD examples into the installdir])
# ARG_OPTIONAL_BOOLEAN([runavdexample],[],[Run AVD example after installing, requires --avdexamples])
# ARG_OPTIONAL_BOOLEAN([verbose],[v],[Print verbose output])
# ARG_HELP([A script to bootstrap the installation of Arista AVD into a venv on most *nix systems])
# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.10.0 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info


die()
{
	local _ret="${2:-1}"
	test "${_PRINT_HELP:-no}" = yes && print_help >&2
	echo "$1" >&2
	exit "${_ret}"
}


begins_with_short_option()
{
	local first_option all_short_options='pdevh'
	first_option="${1:0:1}"
	test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_install="off"
_arg_pythonpath=
_arg_installdir="./avd"
_arg_venv="venv_avd"
_arg_ansibleversion="2.16.7"
_arg_avdversion="4.7.1"
_arg_avdexamples="off"
_arg_runavdexample="off"
_arg_verbose="off"


print_help()
{
	printf '%s\n' "A script to bootstrap the installation of Arista AVD into a venv on most *nix systems"
	printf 'Usage: %s [--(no-)install] [-p|--pythonpath <arg>] [-d|--installdir <arg>] [-e|--venv <arg>] [--ansibleversion <arg>] [--avdversion <arg>] [--(no-)avdexamples] [--(no-)runavdexample] [-v|--(no-)verbose] [-h|--help]\n' "$0"
	printf '\t%s\n' "--install, --no-install: Install AVD, not specifying this will result in a dry run (off by default)"
	printf '\t%s\n' "-p, --pythonpath: The path to the python interpreter instead of the system python (no default)"
	printf '\t%s\n' "-d, --installdir: The path to install avd into (default: './avd')"
	printf '\t%s\n' "-e, --venv: The venv name to use (default: 'venv_avd')"
	printf '\t%s\n' "--ansibleversion: The ansible version to install, be careful changing this (default: '2.16.7')"
	printf '\t%s\n' "--avdversion: The avd version to install, be careful changing this (default: '4.7.1')"
	printf '\t%s\n' "--avdexamples, --no-avdexamples: Copy AVD examples into the installdir (off by default)"
	printf '\t%s\n' "--runavdexample, --no-runavdexample: Run AVD example after installing, requires --avdexamples (off by default)"
	printf '\t%s\n' "-v, --verbose, --no-verbose: Print verbose output (off by default)"
	printf '\t%s\n' "-h, --help: Prints help"
}


parse_commandline()
{
	while test $# -gt 0
	do
		_key="$1"
		case "$_key" in
			--no-install|--install)
				_arg_install="on"
				test "${1:0:5}" = "--no-" && _arg_install="off"
				;;
			-p|--pythonpath)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_pythonpath="$2"
				shift
				;;
			--pythonpath=*)
				_arg_pythonpath="${_key##--pythonpath=}"
				;;
			-p*)
				_arg_pythonpath="${_key##-p}"
				;;
			-d|--installdir)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_installdir="$2"
				shift
				;;
			--installdir=*)
				_arg_installdir="${_key##--installdir=}"
				;;
			-d*)
				_arg_installdir="${_key##-d}"
				;;
			-e|--venv)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_venv="$2"
				shift
				;;
			--venv=*)
				_arg_venv="${_key##--venv=}"
				;;
			-e*)
				_arg_venv="${_key##-e}"
				;;
			--ansibleversion)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_ansibleversion="$2"
				shift
				;;
			--ansibleversion=*)
				_arg_ansibleversion="${_key##--ansibleversion=}"
				;;
			--avdversion)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_avdversion="$2"
				shift
				;;
			--avdversion=*)
				_arg_avdversion="${_key##--avdversion=}"
				;;
			--no-avdexamples|--avdexamples)
				_arg_avdexamples="on"
				test "${1:0:5}" = "--no-" && _arg_avdexamples="off"
				;;
			--no-runavdexample|--runavdexample)
				_arg_runavdexample="on"
				test "${1:0:5}" = "--no-" && _arg_runavdexample="off"
				;;
			-v|--no-verbose|--verbose)
				_arg_verbose="on"
				test "${1:0:5}" = "--no-" && _arg_verbose="off"
				;;
			-v*)
				_arg_verbose="on"
				_next="${_key##-v}"
				if test -n "$_next" -a "$_next" != "$_key"
				then
					{ begins_with_short_option "$_next" && shift && set -- "-v" "-${_next}" "$@"; } || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
				fi
				;;
			-h|--help)
				print_help
				exit 0
				;;
			-h*)
				print_help
				exit 0
				;;
			*)
				_PRINT_HELP=yes die "FATAL ERROR: Got an unexpected argument '$1'" 1
				;;
		esac
		shift
	done
}

parse_commandline "$@"

# OTHER STUFF GENERATED BY Argbash

### END OF CODE GENERATED BY Argbash (sortof) ### ])
# [ <-- needed because of Argbash



# Python 3.10-3.12 required for ansible-core 2.16
# See here: https://docs.ansible.com/ansible/latest/reference_appendices/release_and_maintenance.html#ansible-core-support-matrix
MIN_PYTHON_VERSION="3.10"
REC_PYTHON_VERSION="3.12"

EXAMPLES_DIR="examples"
EXAMPLE_TO_RUN="single-dc-l3ls"

# echomsg used for outputting messages to the user
# echodiag used for outputting any diagnostic info
# echoerr used for outputting any errors
#   all 3 output to stderr
echomsg() { echo "$@" 1>&2; }
echodiag() { if [ "$_arg_verbose" == "on" ]; then echo "$@" 1>&2; fi }
echoerr() { echo "ERROR: $@" 1>&2; }

# Use user supplied python path if provided, otherwise default to system python3
if ! [ "$_arg_pythonpath" == "" ]; then
    python_path=$_arg_pythonpath
else
    python_path=$(which python3)
fi

# Check if we found a python path, if the path is not valid the version check will fail so no need to check
# (maybe we should check but...)
if [ "$python_path" == "" ]; then
    echoerr "Python not found - please use -p, --pythonpath to specify the path to a compatible python interpreter [ $MIN_PYTHON_VERSION - $REC_PYTHON_VERSION ] "
    exit 1
else
    echodiag "Found python at $python_path"
fi

# Check Python version is compatible
python_version=$($python_path --version 2>&1 | awk '{print $2}')
python_version_major=$(echo "$python_version" | cut -d. -f1)
python_version_minor=$(echo "$python_version" | cut -d. -f2)
min_python_version_major=$(echo "$MIN_PYTHON_VERSION" | cut -d. -f1)
min_python_version_minor=$(echo "$MIN_PYTHON_VERSION" | cut -d. -f2)
max_python_version_major=$(echo "$REC_PYTHON_VERSION" | cut -d. -f1)
max_python_version_minor=$(echo "$REC_PYTHON_VERSION" | cut -d. -f2)

if ! [ "$python_version" == "" ] && \
   (( python_version_major > min_python_version_major || ( python_version_major == min_python_version_major && python_version_minor >= min_python_version_minor ) )) && \
   (( python_version_major < max_python_version_major || ( python_version_major == max_python_version_major && python_version_minor <= max_python_version_minor ) )); then
    echodiag "..python version is compatible"
else
    echoerr "Python version NOT compatible, requires $MIN_PYTHON_VERSION - $REC_PYTHON_VERSION, found version $python_version"
    exit 1
fi

# Make sure we can use venv
# First Check if ensurepip is installed, required by venv
# If ensurepip is not there check if we can still create a venv anyways (useful for ubuntu/debian weirdness)
# These checks would not catch the edge case where ensurepip IS installed but venv is not - maybe we should just test venv and forget about ensurepip
$python_path -m ensurepip --version &> /dev/null
if ! [ $? -eq 0 ]; then
    currdir="$(pwd)"
    cd /tmp
    test_venv_name="_$$.tmp"
    $python_path -m venv "$test_venv_name"
    if [ $? == 1 ]; then
        echoerr "Cannot create a venv. Package ensurepip is not usable and cannot create a venv."
        echodiag "On Debian/Ubuntu systems you might need to install the pythonXX-venv package or use a non system interpreter"
        rm -r "$test_venv_name"
        exit 1
    fi
    rm -r "$test_venv_name"
    cd "$currdir"
fi

# Check if install path already exists
if [ -d $_arg_installdir ]; then
  echoerr "Install directory $_arg_installdir already exists. Please delete the directory or specify a different install path"
  exit 1
fi

# If runavdexamples is set but not avdexamples error
if [ $_arg_runavdexample == "on" ] && [ $_arg_avdexamples == "off" ]; then
    echoerr "--runavdexample requires --avdexamples"
    exit 1
fi

# Output config info for dryrun
if [ $_arg_install == "off" ]; then
    echomsg "Config options:"
    echomsg "  Python path: $python_path"
    echomsg "  Python version: $python_version"
    echomsg "  Install Directory: $_arg_installdir"
    echomsg "  venv name: $_arg_venv"
    echomsg "  Ansible version to be installed: $_arg_ansibleversion"
    echomsg "  AVD version to be installed: $_arg_avdversion"
    echomsg "  Install AVD Examples: $_arg_avdexamples"
    echomsg "  Run AVD Example: $_arg_runavdexample"
    echomsg "To install AVD using these facts rerun the same command with the --install flag or use the following command:"
    if [ $_arg_avdexamples == "off" ]; then
        echo "  $0 -p $python_path -d $_arg_installdir -e $_arg_venv --ansibleversion $_arg_ansibleversion --avdversion $_arg_avdversion --install"
    else
        if [ $_arg_runavdexample == "off" ]; then
            echo "  $0 -p $python_path -d $_arg_installdir -e $_arg_venv --ansibleversion $_arg_ansibleversion --avdversion $_arg_avdversion --avdexamples  --install"
        else
            echo "  $0 -p $python_path -d $_arg_installdir -e $_arg_venv --ansibleversion $_arg_ansibleversion --avdversion $_arg_avdversion --avdexamples  --runavdexample --install"
        fi
    fi
    exit 0
fi

# Create and move into installdir
mkdir $_arg_installdir
cd $_arg_installdir

# Create an activate venv
$python_path -m venv $_arg_venv
source $_arg_venv/bin/activate

# Install ansible-core
python3 -m pip install ansible-core==$_arg_ansibleversion

# Install arista.avd ansible collection - we install it into the venv bin as a hack around ansible collection pathing
ansible-galaxy collection install arista.avd:==$_arg_avdversion -p $_arg_venv/bin

# Install AVD depenedencies
ARISTA_AVD_DIR=$(ansible-galaxy collection list arista.avd --format yaml | head -1 | cut -d: -f1)
python3 -m pip install -r $ARISTA_AVD_DIR/arista/avd/requirements.txt

# Install AVD Examples
if [ $_arg_avdexamples == "on" ]; then
    mkdir -p $EXAMPLES_DIR
    cd $EXAMPLES_DIR
    ansible-playbook arista.avd.install_examples
    # Run AVD Example
    if [ $_arg_runavdexample == "on" ]; then
        cd $EXAMPLE_TO_RUN
        ansible-playbook build.yml
    fi
fi

echomsg "Install complete, to use AVD run the following:"
echomsg "\n  cd $_arg_installdir; source $_arg_venv/bin/activate\n"

# ] <-- needed because of Argbash
