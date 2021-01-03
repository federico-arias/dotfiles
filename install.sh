#!/bin/bash

UBUNTU_VERSION=focal
set -e

sudo apt-get update && sudo apt-get upgrade

source "${PWD}/functions.sh"

subcommand=$1
shift

while [ ! $subcommand = "" ]
do
	case "${subcommand}" in
		golang )
			install_go
			exit
			;;
		flutter )
			install_flutter
			exit
			;;
		r )
			install_r
			exit
			;;
		ruby )
			install_ruby
			exit
			;;
		git )
			install_git
			exit
			;;
		latex )
			install_latex
			exit
			;;
	esac
	subcommand=$1
	shift
done

exit
