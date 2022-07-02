#!/bin/env bash
<<EOF
Linux Shellscript Command Line Options/Arguments CLI Application Skeleton Template
EOF

### Declare Variables
# Associative Arrays (Empty)
<<EOF
declare -A flags=()
declare -A help_opts=()
declare -A help_desc=()
EOF

<<EOF
Helper Functions
EOF
FormatTab()
{
	: "
	Format input into a standard Output
	"
	echo -e "\t$1"
}

<<EOF
Design Functions
EOF

<<EOF
Application Business Logic Layer (Processing) Functions
EOF


<<EOF
Main Application Functions
EOF
show_help()
{
	: "
	Displays this help message
	"
	for curr_opt in "${!help_opts[@]}"; do
		curr_opt_args="${help_opts[$curr_opt]}"
		curr_opt_desc="${help_desc[$curr_opt]}"
		FormatTab "{ $curr_opt_args } : $curr_opt_desc"
	done
}

get_options()
{
	: "
	Get Command Line Options
	"
	while [[ $1 != "" ]]; do
		value=$1
		case "$value" in
			#========================================================================#
			# These are some useful command line options typically used in a program
			# Please edit this as required
			# ---
			# Some useful information
			# 1. For all options that dont have an input argument (i.e. $2, $3...)
			#	- shift 1
			# 2. For all options that has an input argument (i.e. $2, $3...)
			#	- shift 2, shift 3, ... shift n according to your number of required inputs
			#========================================================================#
			"-a" | "--all")
				echo -e "Show all information"
				shift 1
				;;
			"-g" | "--get")
				echo -e "Get Value"
				arg="$2"
				echo -e "Option : $value, Input : $arg"
				if [[ ! "$arg" == "" ]]; then
					# Argument provided is not empty
					shift 2
				else
					# No Arguments provided
					shift 1
				fi
				;;
			"-s" | "--set")
				echo -e "Set Value"
				arg="$2"
				echo -e "Option : $value, Input : $arg"
				if [[ ! "$arg" == "" ]]; then
					# Argument provided
					shift 2
				else
					# No Arguments provided
					shift 1
				fi
				;;
			"-h" | "--help")
				echo -e "Display this help message"
				show_help
				break
				shift 1s
				;;
			"-v" | "--version")
				echo -e "Show current version information"
				break
				shift 1s
				;;
			"-V" | "--verbose")
				echo -e "Verbose"
				break
				shift 1s
				;;
			*)
				echo -e "Invalid option, please select another option"
				show_help
				break
				shift 1s
				;;
		esac
	done	
}

init()
{
	: "
	Initialize Variables
	"
	### Associative Array ###
	# NOTE TO SELF:
	#	- gA : Declare a global associative array inside a function
	#		-g : To declare a global variables inside a function
	#		-A : To create an associative array
	declare -gA flags=(
		# [flag_name]=value
	)
	declare -gA help_opts=(
		# Your Help Menu options (short/long named forms here)
		# [opt]="options"
		[all]="-a | --all"
		[get]="-g | --get"
		[set]="-s | --set"
		[help]="-h | --help"
		[verbose]="-V | --verbose"
		[version]="-v | --version"
	)
	declare -gA	help_desc=(
		# Your Help Description and messages here
		# [opt]="opt description"
		[all]="Show all information"
		[get]="Get values from system"
		[set]="Retrieve value from user and set into system for use"
		[help]="Display this help message"
		[verbose]="Set flag for Verbose (standard outputs are shown) output to True"
		[version]="Show current version information"
	)
}

setup()
{
	# Initial Setup processes on Boot-time and Run-time
	init
}

main()
{
	argv=("$@")
	argc="${#argv[@]}"

	# Get Command Line Options
	if [[ "$argc" -gt 0 ]]; then
		# Input found
		get_options "$@"
	else
		# No Arguments found
		echo -e "No options provided."
	fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	setup
	main "$@"
fi
