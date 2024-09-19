#!/bin/bash
sudo pacman -S --needed ufw
sudo systemctl enable ufw
sudo systemctl start ufw
sudo ufw allow ssh
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
sudo ufw status
