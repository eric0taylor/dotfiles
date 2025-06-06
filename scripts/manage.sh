#!/bin/sh
###########################################################
### Manage dotfiles script                              ###
### Author: Eric Taylor <blister0exist@yandex.ru>       ###
### Repo: <https://github.com/eric0taylor/dotfiles.git> ###
###########################################################

# Variables
REPO_PATH="https://github.com/eric0taylor/dotfiles.git"
_dotfiles="/usr/bin/git --git-dir="$HOME/.dotfiles" --work-tree="$HOME""
GITKEY="$HOME/.ssh/github-key"

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
    # Check installing
    if [[ -d "$HOME/.dotfiles" ]];then
      echo "Dotfiles is installed! Use "update". Exit..."
      exit 0
    else
      # Clone repo and do settings
      git clone --bare $REPO_PATH $HOME/.dotfiles
      $_dotfiles checkout
      $_dotfiles config --local status.showUntrackedFiles no
      # set links
      ln -sf /home/$USERNAME/.config/ly/config.ini /etc/ly/config.ini
    fi
    ;;

  update)
  # Check repo and update dotfiles
  # NEED SSH KEY FOR GITHUB
    if [[ -d "$HOME/.dotfiles" ]];then
      $_dotfiles checkout
      $_dotfiles pull origin
    else
      echo "Dotfiles not exist! Use "install". Exit..."
      exit 1
    fi
    ;;

  push)
  # Chenk repo, commit and puch to github
    if [[ -d "$HOME/.dotfiles" && -f $GITKEY ]];then
      read -r -p "Enter commit messege: "
      $_dotfiles commit -m $REPLY
      $_dotfiles push origin
      exit 0
    else
      echo "Dotfiles or github ssh key not exist! Use "install" and add github ssh key. Exit..."
      exit 1
    ;;

  help)
    echo "Script for manage dotfiles"
    echo "Syntax: dotfiles.sh <action>"
    echo "  <action>:"    
    echo "    install: installing dotfiles"
    echo "    update: updating dotfiles"
    echo "    push: upload new configs to github (need github ssh key: ~/.ssh/github-key)"
    echo "    help: show this messege"
    exit 0
    ;;
    
  *)
    echo "Unsupported action! Use "help". Exit..."
    exit 1
    ;;
esac