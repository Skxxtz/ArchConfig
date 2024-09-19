#!/bin/bash
sudo pacman -S --needed git

mkdir ~/.tmp
git clone https://aur.archlinux.org/yay.git ~/.tmp
cd ~/.tmp/yay
makepkg -si yay
mv ~/.tmp/yay /opt/
rm -rf /.tmp


