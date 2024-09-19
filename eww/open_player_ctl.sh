#! /bin/bash



eww daemon &

if [[ $(~/.config/skxxtz/scripts/music/music.sh --status) == "Playing" ]]; then
  eww open music --toggle
else
  eww close music
  notify-send "Noting playing."
fi

