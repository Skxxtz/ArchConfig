#!/bin/bash
sudo pacman -S --needed git

mkdir ~/.tmp
cd ~/.tmp
git clone https://aur.archlinux.org/yay.git
cd ~/.tmp/yay
makepkg -si yay
sudo mv ~/.tmp/yay /opt/
rm -rf /.tmp


