#!/usr/bin/env bash

# Define two numbers
max=255
actual=$(cat /sys/class/backlight/amdgpu_bl1/brightness)
echo $((actual * 100 / max))

