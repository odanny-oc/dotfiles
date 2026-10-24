#!/bin/bash

line=$(hyprctl getoption input:touchpad:disable_while_typing | awk '/^bool:/ {print $2}')

if [[ $line == *"true"* ]]; then
    VALUE="false"
    NOTIF="off"

else
    VALUE="true"
    NOTIF="on"
fi

notify-send --icon==1 -e -t 1200 "disable while typing " $NOTIF && hyprctl eval "hl.config({ input = { touchpad = { disable_while_typing = $VALUE } } })"
