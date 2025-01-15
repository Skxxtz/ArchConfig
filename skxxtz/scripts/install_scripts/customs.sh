#!/bin/bash

# Check if font directory exists, if not, create it
if [[ -d "/usr/share/fonts/OTF" ]]; then
    echo "OTF directory already exists"
else
    echo "Creating OTF font directory..."
    sudo mkdir -p /usr/share/fonts/OTF/
fi
if [[ -d "/usr/share/fonts/TTF" ]]; then
    echo "TTF directory already exists"
else
    echo "Creating TTF font directory..."
    sudo mkdir -p /usr/share/fonts/OTF/
fi

echo "Copying 'wifi-font.otf into otf fonts...'"
sudo cp ~/.config/skxxtz/fonts/wifi-font.otf /usr/share/fonts/OTF/
echo "Copying 'SF-Pro-Display-Medium.otf' into otf fonts...'"
sudo cp ~/.config/skxxtz/fonts/SF-Pro-Display-Medium.otf /usr/share/fonts/OTF/
echo "Copying 'AppleColorEmoji.ttf' into ttf fonts...'"
sudo cp ~/.config/skxxtz/fonts/AppleColorEmoji.ttf /usr/share/fonts/TTF/
echo "Finished copying fonts."

# Check if icon directory exists, if not, create it
if [[ -d "/usr/share/icons" ]]; then
    echo "Icons directory already exists"
else
    echo "Creating OTF font directory..."
    sudo mkdir -p /usr/share/icons/
fi
echo "Copying 'macOS-White' into icons...'"
sudo cp -r ~/.config/skxxtz/icons/macOS-White/ /usr/share/icons/
echo "Finished copying icons."

fc-cache -f -v


rm -rf ~/.bashrc
ln -s ~/.config/skxxtz/confs/backrc ~/.bashrc

rm -rf ~/.bash_profile
ln -s ~/.config/skxxtz/confs/bash_profile ~/.bash_profile

sudo rm -rf /etc/default/grub
sudo ln -s ~/.config/skxxtz/confs/grub /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo mkinitcpio -P
sudo echo "options nvidia-drm modeset=1" > /etc/modprobe.d/nvidia.conf
