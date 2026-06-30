#!/bin/bash

STATE_FILE="/tmp/hypr_monitor_mode"

# Read current mode (default to 0)
current=$(cat "$STATE_FILE" 2>/dev/null || echo "0")

# Cycle to next mode
next=$(( (current + 1) % 3 ))

case $next in
    0)
        hyprctl keyword monitor "HDMI-A-1, 2560x1440@60, 0x-1440, 1"
        notify-send "Monitor Mode" "2560x1440 @ 60Hz (offset)" -i display
        ;;
    1)
        hyprctl keyword monitor "HDMI-A-1, 1920x1080@60, 0x-1080, 1"
        notify-send "Monitor Mode" "1920x1080 @ 60Hz (offset)" -i display
        ;;
    2)
        hyprctl keyword monitor "HDMI-A-1, 1920x1080@60, auto, 1, mirror, eDP-1"
        notify-send "Monitor Mode" "1920x1080 @ 60Hz (mirror eDP-1)" -i display
        ;;
esac

echo "$next" > "$STATE_FILE"
