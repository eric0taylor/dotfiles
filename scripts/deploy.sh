#!/bin/bash
###########################################################
### Install my ALT Linux system                         ###
### Author: Eric Taylor <blister0exist@yandex.ru>       ###
### Note: For ALT Linux - Starterkits - JeOS (systemd)  ###
###########################################################

### VARIABLES
USERNAME="ivan"
SCRIPT_URL="https://raw.githubusercontent.com/eric0taylor/dotfiles/refs/heads/main/scripts/manage.sh "
MANAGE_SCRIPT="/home/$USERNAME/.local/bin/manage.sh"

# Update system
apt-get update && apt-get dist-upgrade -y && apt-get install -y update-kernel && update-kernel -y

# TODO add reboot and "remove-old-kernels -y"

# install soft
apt-get install -y xorg-drv-video xorg-drv-input ly i3 rofi alacritty far2l fonts-ttf-gnu-freefont-mono git sudo wget zsh
# set services
systemctl enable ly
systemctl set-default graphical.target
# set sudo settings
sed -i 's/# root ALL/root ALL/g' /etc/sudoers
# set zsh for root and user
chsh -s /bin/zsh ivan
chsh -s /bin/zsh

# set theme
mkdir -p /usr/share/themes/Windows-95
git clone https://github.com/B00merang-Project/Windows-95.git /usr/share/themes/Windows-95/
rm -rfv /usr/share/themes/Windows-95/{cinnamon,gnome-shell,LICENSE,metacity-1,unity,xfwm4,.git}
# set dotfiles
mkdir /home/$USERNAME/.local/bin/
wget -O $MANAGE_SCRIPT $SCRIPT_URL 
chown $USERNAME:$USERNAME $MANAGE_SCRIPT && chmod +x $MANAGE_SCRIPT
echo "alias dotmanage=\"/home/$USERNAME/.local/manage.sh\"" >> /home/$USERNAME/.zshrc
echo "Login on $USERNAME and do \"dotmanage install\""
echo "Success install. Exit..."