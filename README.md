# Arch Linux

## [Pacman] Packages
git                         |   source control
swaybg                      |   Background image
swaync                      |   Notification center
waybar                      |   Status bar
Hyprland                    |   Window manager
wl-clipboard                |   Clipboard
neovim                      |   IDE
neofetch                    |   Displays system specs
nodejs                      |   Node Java Script
npm                         |   Node Package Manager
grim                        |   Screenshot
slurp                       |   Screenshot
python-dbus                 |   Python pipeline to systemdbus
btop                        |   Process Manager
feh                         |   Preview Images
unzip                       |   Decompression
zip                         |   Compression
rustup                      |   Rust programming language
libnotify                   |   Notification sending
ufw                         |   Firewall

## [Yay] Packages
zen-browser-bin             |   Browser
rofi-lbonn-wayland-git      |   Application launcher
hyprpicker                  |   Color picker "that doesn't suck"

## Configurations

### Yay 
mkdir ~/.tmp
git clone https://aur.archlinux.org/yay.git ~/.tmp
cd ~/.tmp
makepkg -si yay
sudo mv yay /opt
rm -rf ~/.tmp

### Rust
rustup default stable

### Firewall
(~/.config/skxxtz/scripts/install_scripts/firewall.sh)
```
sudo systemctl enable ufw
sudo systemctl start ufw
sudo ufw allow ssh 
sudo ufw default deny incoming 
sudo ufw default allow outgoing 
```
