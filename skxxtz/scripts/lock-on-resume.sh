#!/bin/bash
sleep 1  # Adjust if necessary
export DISPLAY=:0
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export WAYLAND_DISPLAY=wayland-0  # This is the default; adjust if needed
swaylock -f 

