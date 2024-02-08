#!/bin/bash
#
#
# ARG_OPTIONAL_SINGLE([pythonpath],[p],[The path to the python interpreter])
# ARG_OPTIONAL_BOOLEAN([verbose],[v],[Print verbose output])
# ARG_HELP([The general script's help msg])
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
	local first_option all_short_options='pvh'
	first_option="${1:0:1}"
	test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_pythonpath=
_arg_verbose="off"


print_help()
{
	printf '%s\n' "The general script's help msg"
	printf 'Usage: %s [-p|--pythonpath <arg>] [-v|--(no-)verbose] [-h|--help]\n' "$0"
	printf '\t%s\n' "-p, --pythonpath: The path to the python interpreter (no default)"
	printf '\t%s\n' "-v, --verbose, --no-verbose: Print verbose output (off by default)"
	printf '\t%s\n' "-h, --help: Prints help"
}


parse_commandline()
{
	while test $# -gt 0
	do
		_key="$1"
		case "$_key" in
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


MIN_PYTHON_VERSION=3.10
REC_PYTHON_VERSION=3.12

# echodiag used for outputting any diagnostic info
# echoerr used for outputting any errors
# both output to stderr
echodiag() { if [ "$_arg_verbose" == "on" ]; then echo "$@" 1>&2; fi }
echoerr() { echo "ERROR: $@" 1>&2; }

# Use user supplied python path if provided, otherwise default to system python3
if ! [ "$_arg_pythonpath" == "" ]; then
    python_path=$_arg_pythonpath
else
    python_path=$(which python3)
fi

#
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

$python_path -m ensurepip --version &> /dev/null
if ! [ $? -eq 0 ]; then
    echoerr "Python missing package ensurepip"
    exit 1
fi

# ] <-- needed because of Argbash
