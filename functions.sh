#!/bin/bash

install_system () {
	sudo apt-get install -y openbox rofi flameshot inotify-tools jq zsh \
		blueman bluez \
		inkscape gimp blender
	chsh -s /bin/zsh $USER
	# synclient TapButton1=1 #touchpad mouse click
	# Zsh
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	ZSH_CUSTOM=${HOME}/.oh-my-zsh/custom/
	ln -fs ${PWD}/conkyrc ${HOME}/.conkyrc
	ln -fs ${PWD}/autostart.sh ${HOME}/.config/openbox/autostart.sh
	ln -fs ${PWD}/vimrc ${HOME}/.vimrc
	ln -fs ${PWD}/skeletons ${HOME}/.vim/skeleton
	ln -fs ${PWD}/rc.xml ${HOME}/.config/openbox/rc.xml
	ln -fs ${PWD}/user-dirs.dirs ${HOME}/.config/openbox/user-dirs.dirs
	ln -fs ${PWD}/prettierrc ${HOME}/.prettierrc
	ln -fs ${PWD}/gitignore ${HOME}/.gitignore
	# We use this because ${HOME}/.zshrc is overwritten by oh my zsh
	ln -fs ${PWD}/custom.zsh ${ZSH_CUSTOM}/custom.zsh

	[ ! -d ${HOME}/.fonts ] && mkdir ${HOME}/.fonts
	[ ! -d ${HOME}/.screenshots ] && mkdir ${HOME}/.screenshots
	[ ! -d ${HOME}/.config/openbox ] && mkdir -p ${HOME}/.config/openbox
	wget --directory-prefix /tmp https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.focal_amd64.deb
	sudo apt-get install -y xfonts-75dpi
	sudo dpkg -i /tmp/wkhtmltox_0.12.6-1.focal_amd64.deb
	curl https://cli-assets.heroku.com/install.sh | sh
}

install_editor () {
	# Vim
	sudo apt-get install -y vim-gtk
	[ ! -d ${HOME}/.vim ] && mkdir ${HOME}/.vim
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

	# installs linters
	npm install -g csslint markdownlint typescript
	pip3 install proselint

	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
}

install_node() {
	# Node.js
	sudo apt-get install -y build-essential openssl libssl-dev curl ruby ruby-dev rubygems
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
	export NVM_DIR="/home/federico/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
	nvm install --lts=erbium # installs node in ~/.nvm/<versionnumber>/
	nvm use node # changes $PATH to point to latest stable version

	# Yarn
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
	sudo apt update && sudo apt install -y yarn
}

install_git () {
	# git
	sudo apt-get install -y git
	# these are stored in $HOME/.gitconfig
	git config --global diff.tool vimdiff
	git config --global push.followTags true
	git config --global user.name "Federico Arias"
	git config --global user.email "federicoariasr@gmail.com"
	git config --global commit.template $PWD/gittemplate
	git config --global push.default simple
	git config --global core.excludesfile ~/.gitignore
	# asks for credentials once, then remembers them
	# WARNING: potentially unsafe
	git config --global credential.helper store
	git config --global alias.changelog "log --decorate --date=format:'%B %d, %Y' --pretty=format:'%ad: %s (%h)' --abbrev-commit"
}

install_go () {
	echo "Installing Go"
	goversion="1.14.6"
	goarch="amd64"
	goos="linux"
	gofilename=go$goversion.$goos-$goarch.tar.gz
	wget --output-document /tmp/$gofilename https://golang.org/dl/$gofilename
	sudo tar -C /usr/local -xzf /tmp/$gofilename
	go get -u -d github.com/golang-migrate/migrate/cmd/migrate
	cd $GOPATH/src/github.com/golang-migrate/migrate/cmd/migrate
	git checkout v4.12.1
	go build -tags 'postgres' -ldflags="-X main.Version=$(git describe --tags)" \
		-o $GOPATH/bin/migrate $GOPATH/src/github.com/golang-migrate/migrate/cmd/migrate

	go get -u -d github.com/federico-arias/fixtures
	[[ -z $GOPATH ]] && GOPATH=${HOME}/.gows
	go build -o ${HOME}/.local/bin/fixtures \
		${GOPATH}/src/github.com/federico-arias/fixtures
}

install_flutter () {
	sudo apt-get install -y libglu1-mesa
	# Java
	sudo apt-get install -y default-jre default-jdk
	# Android
	sudo apt-get install -y libmtp*
	# Install Android Studio
	# required libraries
	sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
	xdg-open "https://developer.android.com/studio#downloads"
	# Dart
	sudo apt-get install -y apt-transport-https
	sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
	sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
	sudo apt-get update
	sudo apt-get install -y dart

	# flutter
	rm -rf ${HOME}/.flutterrepo && git clone https://github.com/flutter/flutter.git -b stable ${HOME}/.flutterrepo
	PATH="$PATH:${HOME}/.flutterrepo/bin"
	# See: https://robbinespu.gitlab.io/blog/2020/03/03/flutter-issue-fixed-android-license-status-unknown-on-windows/
	flutter doctor
}

install_r () {
	sudo apt-get install -y r-base r-base-dev
	if [ ! -d ${HOME}/.R ]; then
		mkdir ~/.R
	fi
	cat <<EOF > $HOME/.Rprofile
	.libPaths("$HOME/.R")
	local({ r <- getOption('repos'); r['CRAN'] <- 'http://cran.cnr.berkeley.edu/'; options(repos = r) });
EOF
	Rscript -e "install.packages('ggplot2', repos='http://cran.r-project.org');"
}

install_ruby () {
	# See https://stackoverflow.com/q/44555760
	sudo apt-get install -y gnupg2 && sudo apt-get install -y dirmngr
	gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
	curl -sSL https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer | bash -s stable
	source /home/federico/.rvm/scripts/rvm
}

install_python () {
	sudo apt-get install -y python python3 python-dev python3-pip python3-virtualenv
	#virtualenv --python=python3.8 $HOME/.python3
	#source .python3/bin/activate # activates the virtualenv
	#deactivate
}

install_kubernetes () {
	## Docker (this only works on Ubuntu)
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu disco stable" | sudo tee /etc/apt/sources.list.d/docker-ce.list
	sudo apt-get update
	apt-cache policy docker-ce
	sudo apt-get install -y docker-ce
	sudo usermod -aG docker ${USER}

	# Mono
	sudo apt install -y apt-transport-https dirmngr gnupg ca-certificates virtualbox
	sudo apt-get update && sudo apt-get install -y mono-complete

	# Kubectl
	sudo apt-get update && sudo apt-get install -y apt-transport-https curl
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubectl

	## Minikube
	sudo apt-get install -y virtualbox
	curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
		  && chmod +x minikube
	sudo mkdir -p /usr/local/bin/
	sudo install minikube /usr/local/bin/
	minikube config set driver virtualbox
}
