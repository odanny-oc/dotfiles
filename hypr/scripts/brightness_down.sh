!#/bin/bash

brightnessctl -d amdgpu_bl1 s 10%-

BRIGHTNESS=$(brightnessctl | grep -oP "\d+%")

notify-send --icon==1 -e -t 1300 "Brightness $BRIGHTNESS"

