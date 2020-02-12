#!/bin/bash

set -e
sudo apt-get update && sudo apt-get upgrade

# Openbox
sudo apt-get install -y openbox curl

# git
sudo apt-get install -y git
git config --global diff.tool vimdiff
git config --global user.name "Federico Arias"
git config --global user.email ""

# Java
sudo apt-get install -y default-jre libreoffice jabref

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
if [ ! -d ${HOME}/.vim ]; then
	mkdir ${HOME}/.vim
fi
if [ ! -d ${HOME}/.fonts ]; then
	mkdir ${HOME}/.fonts
fi
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

wget https://github.com/darold/pgFormatter/archive/master.zip
unzip master.zip -d .
cd pgFormatter-master/
perl Makefile.PL
make && sudo make install

# Test frameworks

# copy config files

if [ ! -d ${HOME}/.config/openbox ]; then
	mkdir -p ~/.config/openbox
fi

if [ ! -f ${HOME}/.conkyrc ]; then
	ln -s ${PWD}/conkyrc ${HOME}/.conkyrc
fi

ln -s ${PWD}/autostart.sh ${HOME}/.config/openbox/autostart.sh
ln -s ${PWD}/vim ${HOME}/.vimrc
ln -s ${PWD}/skeletons ${HOME}/.vim/skeleton
ln -s ${PWD}/rc.xml ${HOME}/.config/openbox/rc.xml
ln -s ${PWD}/user-dirs.dirs ${HOME}/.config/openbox/user-dirs.dirs


##########################################################################
# DIY
##########################################################################

# sudo add-apt-repository ppa:freecad-maintainers/freecad-stable
# sudo apt-get install -y freecad freecad-doc

# removes lock screen from resume and after idle time
sudo apt-get purge ligth-locker

git config credential.helper store
