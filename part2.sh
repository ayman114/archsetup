#!/bin/sh

# archchroot


# set hostname
echo 5537 > /etc/hostname
echo "127.0.1.1 5537.localdomain  5537" >> /etc/hosts

# set timezone
ln -sf /usr/share/zoneinfo/Africa/Cairo /etc/localtime

# generate locale
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ar_EG.UTF-8 UTF-8" > /etc/locale.gen
echo "en_US ISO-8859-1" >> /etc/locale.gen
locale-gen


# Set root password
passwd

# Install bootloader
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch
grub-mkconfig -o /boot/grub/grub.cfg


# create user
useradd -m -G wheel -s /bin/zsh ayman

echo "Set password for new user ayman"
passwd ayman

# configure xinit
echo "exec awesome" > /home/arch/.xinitrc

# configure sudo 
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers


# Enable services
systemctl enable NetworkManager.service

# let user know that the install finished
echo "Install Finished"
