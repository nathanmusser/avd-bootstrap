# AVD-Bootstrap

AVD-Bootstrap is a bash script to bootstrap the installation of AVD into a venv on *most* \*nix systems. If you get an error running the script please open an issue with the flavor of OS you're running and the python version you have installed so I can help adjust the script to catch possible edge cases.

## Installation

Download the [latest release](https://github.com/nathanmusser/avd-bootstrap/releases/latest) from Releases page

## Usage

`.\avd-bootstrap.sh` will do a dry-run and show you any potential problems you might have running the script. 

To actually install you need to add a `--install` flag or you can pipe the output of the dry-run into a shell: `.\avd-bootstrap.sh | sh`

```
./avd-bootstrap.sh [--(no-)install] [-p|--pythonpath <arg>] [-d|--installdir <arg>] [-e|--venv <arg>] [--ansibleversion <arg>] [--avdversion <arg>] [--(no-)avdexamples] [--(no-)runavdexample] [-v|--(no-)verbose] [-h|--help]
        --install, --no-install: Install AVD, not specifying this will result in a dry run (off by default)
        -p, --pythonpath: The path to the python interpreter instead of the system python (no default)
        -d, --installdir: The path to install avd into (default: './avd')
        -e, --venv: The venv name to use (default: 'venv_avd')
        --ansibleversion: The ansible version to install, be careful changing this (default: '2.16.3')
        --avdversion: The avd version to install, be careful changing this (default: '4.5.0')
        --avdexamples, --no-avdexamples: Copy AVD examples into the installdir (off by default)
        --runavdexample, --no-runavdexample: Run AVD example after installing, requires --avdexamples (off by default)  
        -v, --verbose, --no-verbose: Print verbose output (off by default)
        -h, --help: Prints help
```


## Contributing
Pull requests are welcome for this project.

This project is leveraging [argbash](https://argbash.dev/) for the argument parsing. avd-bootstrap.template is the pre-processed script with the macros present. PRs should make changes to this file and then releases are based on the wrapped file. 
