# Services

## Battery Checker
### Setup
Create symlinks for the power level files. Then enable and start the timer.
```
1. sudo ln -s ~/.config/skxxtz/bin/powerlevel /usr/bin/check-powerlevel
<<<<<<< HEAD
2. sudo ln -s ~/.config/skxxtz/services/battery_checker.timer /usr/lib/systemd/system/battery_checker.timer
3. sudo ln -s ~/.config/skxxtz/services/battery_checker.service /usr/lib/systemd/system/battery_checker.service

4. sudo systemctl daemon-reload
5. sudo systemctl enable battery_checker.timer
6. sudo systemctl start battery_checker.timer
7. sudo systemctl status battery_checker.service
=======
2. sudo ln -s ~/.config/skxxtz/services/battery_check.timer /usr/lib/systemd/system/battery_check.timer
3. sudo ln -s ~/.config/skxxtz/services/battery_check.service /usr/lib/systemd/system/battery_check.service

4. sudo systemctl daemon-reload
5. sudo systemctl enable battery_check.timer
6. sudo systemctl start battery_check.timer
7. sudo systemctl status battery_check.service
>>>>>>> main
```


