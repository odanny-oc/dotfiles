#!/bin/bash

STATE_FILE="/tmp/hypr_monitor_mode"

# Read current mode (default to 0)
current=$(cat "$STATE_FILE" 2>/dev/null || echo "0")

# Cycle to next mode
next=$(( (current + 1) % 3 ))

case $next in
    0)
        hyprctl eval 'hl.monitor({ output = "HDMI-A-1", mode = "2560x1440@60", position = "0x-1440", scale = 1 })'
        notify-send -e -t 1300 --replace-id=5 "Monitor Mode" "2560x1440 @ 60Hz (offset)" -i display
        ;;
    1)
        hyprctl eval 'hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "0x-1080", scale = 1 })'
        notify-send -e -t 1300 --replace-id=5 "Monitor Mode" "1920x1080 @ 60Hz (offset)" -i display
        ;;
    2)
        hyprctl eval 'hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "auto", scale = 1, mirror = "eDP-1" })'
        notify-send -e -t 1300 --replace-id=5 "Monitor Mode" "1920x1080 @ 60Hz (mirror eDP-1)" -i display
        ;;
esac

echo "$next" > "$STATE_FILE"
