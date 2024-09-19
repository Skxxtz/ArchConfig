#!/bin/bash

killall waybar
killall swaync

if [[ $USER == "basti" ]]; then
	waybar &
    swaync &
    hyprctl reload &

else 
	waybar &

fi



