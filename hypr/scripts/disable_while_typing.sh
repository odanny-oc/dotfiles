#!/bin/bash

line=$(hyprctl getoption input:touchpad:disable_while_typing | awk "/int: /")

if [[ $line == *"int: 1"* ]]; then
    VALUE="false"
    NOTIF="off"

else
    VALUE="true"
    NOTIF="on"
fi

notify-send --icon==1 -e -t 1200 "disable while typing " $NOTIF && hyprctl keyword input:touchpad:disable_while_typing $VALUE 
