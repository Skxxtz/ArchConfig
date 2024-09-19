#!/bin/bash

# Check if the music client configuration file exists and is non-empty
if [ ! -s ~/.config/skxxtz/confs/music_client ]; then
  echo "Error: Music client configuration file is missing or empty." >&2
  exit 1
fi

# Read the music player from the configuration file
player=$(< ~/.config/skxxtz/confs/music_client)

# Handle command-line arguments
case "$1" in
  "--song")
    playerctl metadata title | cut -c -80
    ;;
  "--artist")
    playerctl metadata artist | cut -c -80
    ;;
  "--status")
    playerctl status
    ;;
  "--get-shuffle")
    playerctl shuffle
    ;;
  "--shuffle")
    playerctl shuffle Toggle
    ;;
  "--next")
    playerctl next
    ;;
  "--previous")
    playerctl previous
    ;;
  "--get-loop")
    playerctl loop
    ;;
  "--loop-off")
    playerctl loop Playlist
    ;;
  "--loop-on")
    playerctl loop Track
    ;;
  "--get-art")
    echo "$(playerctl metadata | grep -oP 'mpris:artUrl\s+\K\S+')"  
    ;;
  "--play-pause")
    playerctl play-pause
    ;;
    *)
    echo "Usage: $0 {--song|--artist|--status|--get-shuffle|--shuffle|--next|--previous|--get-loop|--loop-off|--loop-on}" >&2
    exit 1
    ;;
esac

exit 0
