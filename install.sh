#!/bin/bash
###########################################################
### Install dotfiles script                             ###
### Author: Eric Taylor <blister0exist@yandex.ru>       ###
### Repo: <https://github.com/eric0taylor/dotfiles.git> ###
### License: MIT                                        ###
###########################################################

# VARS
REPO_PATH="https://github.com/eric0taylor/dotfiles.git"

# Check args
if [ -z "$1" ]
  then
    echo "No argument supplied!"
    exit 1
fi

# Check distro
case "$1" in
  arch)
    BRANCH="arch"
    ;;
  slinux)
    BRANCH="slinux"
    ;;
  *)
    echo "Unsupported distro! Exit..."
    exit 1
    ;;
esac

# Clone dotfiles 
git clone --branch $BRANCH --single-branch --bare $REPO_PATH $HOME/.dotfiles
# Settings for git
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
dotfiles checkout $BRANCH
dotfiles config --local status.showUntrackedFiles no