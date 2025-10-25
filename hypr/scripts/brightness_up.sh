!#/bin/bash

BRIGHTNESS=$(brightnessctl | grep -oP "\d+%")

brightnessctl -d amdgpu_bl1 s 10%+ && notify-send --icon==1 -e -t 1300 "Brightness $BRIGHTNESS"

