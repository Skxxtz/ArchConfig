#!/bin/bash


current=$(cat /sys/class/leds/asus::kbd_backlight/brightness)

echo "$current"
if [[ "$current" -gt 0 ]]; then
    brightnessctl --device="asus::kbd_backlight" set 0
else
    brightnessctl --device="asus::kbd_backlight" set 1
fi
