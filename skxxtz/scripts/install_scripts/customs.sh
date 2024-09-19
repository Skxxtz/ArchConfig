#!/bin/bash

# Check if font directory exists, if not, create it
if [[ -d "/usr/share/fonts/OTF"]]; then
else
    echo "Creating OTF font directory..."
    sudo mkdir -p /usr/share/fonts/OTF/
fi
sudo cp ~/.config/skxxtz/fonts/wifi-font.otf /usr/share/fonts/OTF/
sudo cp ~/.config/skxxtz/fonts/SF-Pro-Display-Medium.otf /usr/share/fonts/OTF/

# Check if icon directory exists, if not, create it
if [[ -d "/usr/share/icons"]]; then
else
    echo "Creating OTF font directory..."
    sudo mkdir -p /usr/share/icons/
fi
sudo cp -r ~/.config/skxxtz/icons/macOS-White/ /usr/share/icons/


rm -rf ~/.bashrc
rm -rf ~/.bash_profile

ln -s ~/.config/skxxtz/confs/bash_profile ~/.bash_profile
ln -s ~/.config/skxxtz/confs/backrc ~/.bashrc



