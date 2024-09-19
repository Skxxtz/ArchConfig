sudo pacman -S --needed libnotify swaync

sudo ln -s ~/.config/skxxtz/bin/powerlevel /usr/bin/check-powerlevel
sudo ln -s ~/.config/skxxtz/services/battery_check.timer /usr/lib/systemd/system/battery_check.timer
sudo ln -s ~/.config/skxxtz/services/battery_check.service /usr/lib/systemd/system/battery_check.service

sudo systemctl daemon-reload
sudo systemctl enable battery_check.timer
sudo systemctl start battery_check.timer
sudo systemctl status battery_check.service
