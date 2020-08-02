#!/bin/zsh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

unset PYTHONHOME
unset PYTHONPATH
export ZSH=$HOME/.oh-my-zsh
# Ruby
export GEM_HOME=$HOME/.gems
export PATH=$HOME/.gems/bin:$PATH
# Golang
export GOPATH=$HOME/.gows
export PATH="$PATH:$GOPATH/bin:/usr/local/go/bin"
# Conscript (what is this?)
export CONSCRIPT_HOME="$HOME/.conscript"
export CONSCRIPT_OPTS="-XX:MaxPermSize=512M -Dfile.encoding=UTF-8"
export PATH="$PATH:$CONSCRIPT_HOME/bin"
# Python virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/.devel
# Java
export JAVA_HOME="/usr/lib/jvm/default-java"
#export GRADLE_HOME="$HOME/.graddle2/gradle-2.14"
#export PATH="$PATH:$GRADLE_HOME/bin:"
# Scala
export SCALA_HOME=$HOME/.scala
export ACTIVATOR_HOME="$HOME/.activator/activator-dist-1.3.10"
export PATH="$PATH:$ACTIVATOR_HOME/bin:$SCALA_HOME/bin"
# Flutter
export PATH="$PATH:${HOME}/.flutterrepo/bin:/opt/android-studio/bin:${HOME}/.android-sdk/tools/bin"
export ANDROID_SDK_ROOT="${HOME}/.android-sdk"
# Local paths
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:$HOME/.local/bin:/snap/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
autoload -U add-zsh-hook
add-zsh-hook chpwd load-nvmrc
load-nvmrc
