#!/bin/bash
input=$1
scaled_value=$(( input * 255 / 100 ))

if (( scaled_value >= 25 && scaled_value <= 255 )); then
    echo "$scaled_value" > /sys/class/backlight/amdgpu_bl1/brightness
else
    echo 0
fi

