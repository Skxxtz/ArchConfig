#!/usr/bin/env bash

uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`

# Options
shutdown='⏻  Shutdown'
reboot='󰑓  Reboot'
lock='  Lock'
suspend='󰏥  Suspend'
logout='󰍃  Logout'
yes=''
no='󱊷'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
        -i \
		-p "$host" \
		-theme '~/.config/rofi/power.rasi'
}

# Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you sure?' \
        -theme '~/.config/rofi/confirm.rasi'
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
    echo -e "$suspend\n$shutdown\n$logout\n$reboot\n$lock" | rofi_cmd
}

# Execute Command
run_cmd() {
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			systemctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			systemctl reboot
		elif [[ $1 == '--logout' ]]; then
            loginctl terminate-session $XDG_SESSION_ID
		fi
	else
		exit 0
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $lock)
        swaylock
        ;;
    $suspend)
        systemctl suspend &
        swaylock
        ;;
    $logout)
		run_cmd --logout
        ;;
esac
