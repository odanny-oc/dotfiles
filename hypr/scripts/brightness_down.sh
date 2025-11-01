!#/bin/bash

icon_path="$HOME/.config/icons"

brightnessctl -d amdgpu_bl1 s 10%-

BRIGHTNESS=$(brightnessctl | grep -oP "\d+%")

notify-send --replace-id=1 -i "$icon_path/brightness_down.png" -e -t 1300 " Brightness $BRIGHTNESS"

