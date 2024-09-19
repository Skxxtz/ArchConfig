#!/usr/bin/env bash

if command -v wpctl > /dev/null 2>&1; then
  wpctl set-volume @DEFAULT_SINK@ $1
else
  pactl set-sink-volume @DEFAULT_SINK@ $1
fi

