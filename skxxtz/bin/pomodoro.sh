#!/bin/bash

# Initialize flag variables
flag_s=false
flag_t=false

# Parse command-line options
while getopts "st" opt; do
    case ${opt} in
        s) flag_s=true ;;
        t) flag_t=true ;;
        \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
    esac
done

# Shift the options so that $1 now refers to the first non-option argument
shift $((OPTIND - 1))

# Check flags and perform actions
if $flag_s; then
    echo "Executing Python script: /home/basti/.config/skxxtz/scripts/pomodoro/main.py"
    python3 /home/basti/.config/skxxtz/scripts/pomodoro/main.py  # Use python3 explicitly
fi

if $flag_t; then
    if [ -f "/tmp/usr/pomodoro_daemon.pid" ]; then
        echo "Killing process with PID $(cat /tmp/usr/pomodoro_daemon.pid)"
        kill $(cat /tmp/usr/pomodoro_daemon.pid)
    else
        echo "File /tmp/usr/pomodoro_daemon.pid not found. Cannot kill process."
    fi
fi
