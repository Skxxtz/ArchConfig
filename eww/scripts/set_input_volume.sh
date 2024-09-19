#!/usr/bin/env bash

if command -v wpctl > /dev/null 2>&1; then
  wpctl set-volume @DEFAULT_SOURCE@ $1
else
  pactl set-source-volume @DEFAULT_SOURCE@ $1
fi

