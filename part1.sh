#!/bin/sh

# partitioning and swap
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4

# mount the partitions

mount /dev/sda3 /mnt
mkdir -pv /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
swapon /dev/sda2
mkdir -pv /mnt/home
mount /dev/sda4 /mnt/home


# install
pacstrap /mnt base base-devel linux linux-firmware vim git networkmanager grub os-prober zsh efibootmgr dosfstools xorg-server xorg-xinit 

# copy the second script
cp part2.sh /mnt/part2.sh

# generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# change root
arch-chroot /mnt ./part2.sh

