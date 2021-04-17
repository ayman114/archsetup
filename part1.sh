#!/bin/sh

# partitioning and swap
mkswap /dev/sda2
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda3

# mount the partitions

mount /dev/sda1 /mnt
swapon /dev/sda2
mkdir -pv /mnt/home
mount /dev/sda3 /mnt/home


# install
pacstrap /mnt base base-devel linux linux-firmware vim git networkmanager grub zsh dosfstools xorg-server  mesa xf86-video-intel lightdm lightdm-gtk-greeter bspwm sxhkd alacritty

# copy the second script
cp part2.sh /mnt/part2.sh

# generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# change root
arch-chroot /mnt ./part2.sh

