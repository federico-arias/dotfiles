#!/bin/bash

set -e
sudo apt-get update && sudo apt-get upgrade
sudo add-apt-repository ppa:linuxuprising/shutter

# Mono
sudo apt install apt-transport-https dirmngr gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/debian stable-stretch main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt-get update && sudo apt-get install -y mono-complete

# Kubectl
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# Openbox
sudo apt-get install -y openbox

# Docker (this only works on Ubuntu)
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo bash -c 'echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu disco stable" > /etc/apt/sources.list.d/docker-ce.list'
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get install -y docker-ce
sudo usermod -aG docker ${USER}

# git
sudo apt-get install -y git
git config --global diff.tool vimdiff
git config --global push.followTags true
git config --global user.name "Federico Arias"
git config --global user.email "federicoariasr@gmail.com"
git config --global commit.template $pwd/gittemplate
git config --global push.default simple
# asks for credentials once, then remembers them
# warning: potentially unsafe
git config --global credential.helper store
git config --global alias.changelog \
	"log --decorate --date=format:'%B %d, %Y' --pretty=format:'%ad: %s (%h)' --abbrev-commit"

# Java
sudo apt-get install -y default-jre default-jdk

# Android
sudo apt-get install -y libmtp*

# Dart
sudo apt-get install -y apt-transport-https
sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
sudo apt-get update
sudo apt-get install -y dart
# flutter
git clone https://github.com/flutter/flutter.git -b stable ${HOME}/.flutterrepo
export PATH="$PATH:${HOME}/.flutterrepo/bin"
flutter doctor


# R
sudo apt-get install -y r-base r-base-dev
cd $HOME
if [ ! -d ${HOME}/.R ]; then
	mkdir ~/.R
fi
cat <<EOF > $HOME/.Rprofile
.libPaths("$HOME/.R")
local({ r <- getOption('repos'); r['CRAN'] <- 'http://cran.cnr.berkeley.edu/'; options(repos = r) });
EOF
Rscript -e "install.packages('ggplot2', repos='http://cran.r-project.org');"

# Ruby
# See https://stackoverflow.com/q/44555760
sudo apt-get install -y gnupg2 && sudo apt-get install -y dirmngr
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer | bash -s stable
source /home/federico/.rvm/scripts/rvm
#gem instal sqlint

# Python
sudo apt-get install -y python python3 python-dev python-virtualenv
virtualenv --python=python3.7 $HOME/.python3
virtualenv --python=python2.7 $HOME/.python2 # Creates virtual environments for python
source .python2/bin/activate # activates the virtualenv
deactivate

# Node.js
sudo apt-get install -y build-essential openssl libssl-dev curl ruby ruby-dev rubygems
curl https://raw.githubusercontent.com/creationix/nvm/v0.24.0/install.sh | bash
export NVM_DIR="/home/federico/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install --lts=erbium # installs node in ~/.nvm/<versionnumber>/
nvm use node # changes $PATH to point to latest stable version

# Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install -y yarn

# LaTex
# sudo apt-get install -y pandoc texlive-full
# mkdir -p ${HOME}/.pandoc/templates
# git clone https://github.com/Wandmalfarbe/pandoc-latex-template
# cp pandoc-latex-template/eisvogel.tex ${HOME}/.pandoc/templates/eisvogel.latex

##########################################################################
# Graphic design
##########################################################################

sudo apt-get install -y inkscape gimp blender

##########################################################################
# Game Development
##########################################################################

sudo add-apt-repository mapeditor.org/tiled
wget https://www.codeandweb.com/texturepacker/start-download?os=ubuntu&bits=64

# Vim
sudo apt-get install -y vim
[ ! -d ${HOME}/.vim ] && mkdir ${HOME}/.vim
[ ! -d ${HOME}/.fonts ] && mkdir ${HOME}/.fonts
[ ! -d ${HOME}/.screenshots ] && mkdir ${HOME}/.screenshots
mkdir -p "${HOME}/.vim/colors"
wget https://raw.githubusercontent.com/morhetz/gruvbox/master/colors/gruvbox.vim
mv gruvbox.vim ~/.vim/colors/
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
PATHOGEN_FOLDER=${HOME}/.vim/bundle
git clone https://github.com/dense-analysis/ale.git ${PATHOGEN_FOLDER}/ale
git clone https://github.com/fatih/vim-go.git ${PATHOGEN_FOLDER}/vim-go
git clone https://github.com/junegunn/vim-easy-align ${PATHOGEN_FOLDER}/vim-easy-align
git clone https://github.com/plasticboy/vim-markdown.git ${PATHOGEN_FOLDER}/vim-markdown

# Linters + code generator + documentation + testing framework

# installs linters
npm install -g csslint markdownlint typescript
pip install proselint

# deprecate this! prefer sql-fmt
wget https://github.com/darold/pgFormatter/archive/master.zip
unzip master.zip -d .
cd pgFormatter-master/
perl Makefile.PL
make && sudo make install

# fzf
#git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
#~/.fzf/install
sudo apt-get install -y fzf

# Test frameworks

# copy config files

if [ ! -d ${HOME}/.config/openbox ]; then
	mkdir -p ~/.config/openbox
fi

ln -fs ${PWD}/conkyrc ${HOME}/.conkyrc
ln -fs ${PWD}/autostart.sh ${HOME}/.config/openbox/autostart.sh
ln -fs ${PWD}/zshrc ${HOME}/.zshrc
ln -fs ${PWD}/vim ${HOME}/.vimrc
ln -fs ${PWD}/skeletons ${HOME}/.vim/skeleton
ln -fs ${PWD}/rc.xml ${HOME}/.config/openbox/rc.xml
ln -fs ${PWD}/user-dirs.dirs ${HOME}/.config/openbox/user-dirs.dirs


##########################################################################
# DIY
##########################################################################

# sudo add-apt-repository ppa:freecad-maintainers/freecad-stable
# sudo apt-get install -y freecad freecad-doc

# removes lock screen from resume and after idle time
sudo apt-get purge ligth-locker
