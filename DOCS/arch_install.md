# Install
### 1) Connect to internet
### 2) Create partitions
### 3) Mount partition to `/mnt`
### 4) Config pacman 
```bash 
pacman-key --init
pacman-key --populate archlinux
```
and add to `/etc/pacman.conf` 
```sh
ParallelDownloads=20
Color
```
set mirrors in `.etc.pacman.d/mirrorlist`
### 5) Install base system
```bash
pacstrap /mnt base base-devel linux linux-firmware linux-headers intel-ucode amd-ucode vim
```
### 6) Generate fstab
```bash
genfstab -pU /mnt >> /mnt/etc/fstab
```
### 7) Change root directory
```bash
arch-chroot /mnt
```
### 8) Set user settings
```bash
# change root pass
passwd
# set hostname
echo "<HOSTNAME>" > /etc/hostname
# set local time
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
# set locale
vim /etc/locale.gen
    # uncomment that:
    ..
    ru_RU.UTF8 UTF8
    en_US.UTF8 UTF8
    ..
    :wq
# genetate locale
locale-gen
# set cyrilic in tty
echo "KEYMAP=ru\nFONT=cyr-sun16" > /etc/vconsole.conf
# set system locale
echo "LANG=\"ru_RU.UTF-8\"" > /etc/locale.conf
# isntall user soft
pacman -Sy
pacman -S arch-install-scripts git htop networkmanager wget zsh xdg-user-dirs sudo
# generate init disk
mkinitcpio -P
# set sudo group
vim /etc/sudoers
    ...
    # uncomment that
    %wheel ALL=(ALL:ALL) ALL
    ...
    :wq
# create user
useradd -mg users -G wheel <USERNAME>
passwd <USERNAME>
# enable autostart
systemctl enable NetworkManage
# install grub
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch
grub-mkconfig -o /boot/grub/grub.cfg
# install video drivers
# for intel
pacman -S xf86-video-intel
# for amd
pacman -S lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader
# for nvidia
pacman -S nvidia-utils lib32-nvidia-utils nvidia-settings nvidia-dkms
```
### 9) Finish
```bash
exit
umount -R /mnt
reboot
```