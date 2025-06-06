#!/bin/bash
###########################################################
### Install my ALT Linux system                         ###
### Author: Eric Taylor <blister0exist@yandex.ru>       ###
### Note: For ALT Linux - Starterkits - JeOS (systemd)  ###
###########################################################

### VARIABLES
USERNAME="ivan"
SOFT_LIST=(xorg-drv-video xorg-drv-input ly i3 rofi alacritty far2l fonts-ttf-gnu-freefont-mono git)

# Update system
apt-get update && apt-get dist-upgrade -y && apt-get install -y update-kernel && update-kernel -y

# TODO add reboot and "remove-old-kernels -y"

# install soft
apt-get install -y $SOFT_LIST
# set services
systemctl enable ly
systemctl set-default graphical.target

# set theme
mkdir -p /usr/share/themes/Windows-95
git clone https://github.com/B00merang-Project/Windows-95.git /usr/share/themes/Windows-95/
rm -rfv /usr/share/themes/Windows-95/{cinnamon,gnome-shell,LICENSE,metacity-1,unity,xfwm4,.git}
# set dotfiles
su - ivan
sh -c "$(curl -fsSL https://raw.githubusercontent.com/eric0taylor/dotfiles/refs/heads/main/scripts/deploy.sh) install"