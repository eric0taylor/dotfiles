#!/bin/sh
###########################################################
### Manage dotfiles script                              ###
### Author: Eric Taylor <blister0exist@yandex.ru>       ###
### Repo: <https://github.com/eric0taylor/dotfiles.git> ###
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

# Check action
case "$1" in
  install)
    if [[ -d "$HOME/.dotfiles" ]];then
      echo "Dotfiles is installed! Use "update". Exit..."
      exit 0
    else
      git clone --bare $REPO_PATH $HOME/.dotfiles
      $_dotfiles checkout
      $_dotfiles config --local status.showUntrackedFiles no
    fi
    ;;

  update)
    if [[ -d "$HOME/.dotfiles" ]];then
      $_dotfiles pull origin
    else
      echo "Dotfiles not exist! Use "install". Exit..."
      exit 1
    fi
    ;;

  push)
    read -r -p "Enter commit messege: "
    $_dotfiles commit -m $REPLY
    $_dotfiles push origin
    exit 0
    ;;

  help)
    echo "Script for manage dotfiles\nSyntax: dotfiles.sh <action>\n  <action>:\n    install: installing dotfiles\n    update: updating dotfiles\n    push: upload new configs to github\n    help: show this messege"
    exit 0
    ;;
    
  *)
    echo "Unsupported action! Use "help". Exit..."
    exit 1
    ;;
esac