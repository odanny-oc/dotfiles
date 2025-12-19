!#/bin/bash

device=$(brightnessctl -l | awk -F"'" '/Device/ { print $2; exit }')

icon_path="$HOME/.config/icons"

brightnessctl -d $device s 10%-

BRIGHTNESS=$(brightnessctl | grep -oP "\d+%")

notify-send --replace-id=1 -i "$icon_path/brightness_down.png" -e -t 1300 " Brightness $BRIGHTNESS"

