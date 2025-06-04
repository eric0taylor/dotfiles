#!/bin/bash
###########################################################
### Install dotfiles script                             ###
### Author: Eric Taylor <blister0exist@yandex.ru>       ###
### Repo: <https://github.com/eric0taylor/dotfiles.git> ###
### License: MIT                                        ###
###########################################################

# Variables
REPO_PATH="https://github.com/eric0taylor/dotfiles.git"
_dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

# Check git settings
if [[ -f $HOME/.gitconfig ]]; then
  read -r -p "Enter your name: "
  git config --global user.name "$REPLY"
  read -r -p "Enter your email: "
  git config --global user.email "$REPLY"
fi

# Check distro
case "$2" in
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

# Check action
case "$1" in
  install)
    if [[ -d "$HOME/.dotfiles" ]];then
      echo "Dotfiles is installed! Exit..."
      exit 0
    else
      git clone --branch $BRANCH --single-branch --bare $REPO_PATH $HOME/.dotfiles
      $_dotfiles checkout $BRANCH
      $_dotfiles config --local status.showUntrackedFiles no
    fi
    ;;

  update)
    if [[ -d "$HOME/.dotfiles" ]];then
      $_dotfiles pull origin $BRANCH
    else
      echo "Dotfiles not exist! Exit..."
      exit 1
    fi
    ;;

  push)
    # Need ssh private key on my GitHub!!!
    read -r -p "Enter commit messege: "
    $_dotfiles commit -m $REPLY
    $_dotfiles push origin $BRANCH
    ;;

  help)
    echo " \
Script for manage dotfiles  \n \
Syntax: dotfiles.sh <action> <distro> \n \
  <action>: \n \
    install: isntalling dotfiles \n \
    update: updating dotfiles \n \
    push: upload new configs to github \n \
    help: show this messege \n \
  <distro>: \n \
    arch: archlinux \n \
    slinux: simply linux (Alt)"
    ;;

  *)
    echo "Unsupported action! Exit..."
    exit 1
    ;;
esac