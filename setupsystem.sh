#!/bin/bash

UBUNTU_VERSION=focal
subcommand=$1

shift
set -e

source "${PWD}/functions.sh"

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
esac

exit

sudo apt-get update && sudo apt-get upgrade

# Postgres
sudo apt-get install -y postgresql

# Pair programming
sudo apt-get install -y tmux
if [[ -z $(getent passwd invitado) ]]
then
	sudo adduser invitado
	sudo usermod -a -G users invitado
fi

# LaTex

sudo add-apt-repository mapeditor.org/tiled
wget https://www.codeandweb.com/texturepacker/start-download?os=ubuntu&bits=64

# fzf
sudo apt-get install -y fzf

# Copy config files

if [ ! -d ${HOME}/.config/openbox ]; then
	mkdir -p ~/.config/openbox
fi

##########################################################################
# DIY
##########################################################################

sudo add-apt-repository ppa:freecad-maintainers/freecad-stable
sudo apt-get install -y freecad freecad-doc

# removes lock screen from resume and after idle time
#sudo apt-get purge light-locker
