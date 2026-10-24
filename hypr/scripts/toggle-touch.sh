#!/bin/bash
DEVICE="wacom-hid-5218-finger"
STATE_FILE="/tmp/hypr-$DEVICE"

if [ -f "$STATE_FILE" ]; then
    hyprctl eval "hl.device({ name = '$DEVICE', enabled = true })"
    notify-send -t 2000 -e --replace-id=7 "Touch enabled" -i display
    rm "$STATE_FILE"
else
    hyprctl eval "hl.device({ name = '$DEVICE', enabled = false })"
    notify-send -t 2000 -e --replace-id=7 "Touch disabled" -i display
    touch "$STATE_FILE"
fi
