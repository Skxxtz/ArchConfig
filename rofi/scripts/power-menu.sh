#!/bin/bash
if [ -z "$1" ]; then
    options="Shutdown\nReboot\nLogout"
    echo -e "$options" | sed 's/^power: //'
else
    case "$1" in
        "Shutdown")
            shutdown -h now
            ;;
	"Reboot")
	    reboot
	    ;;
	"Logout")
	    loginctl terminate-session $XDG_SESSION_ID
	    ;;
        *)
            echo "Invalid command: $1"
            exit 1
            ;;
    esac
fi


