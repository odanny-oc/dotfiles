#!/bin/bash

NOTIFIEDFILE=".notified"

if [[ -f "$NOTIFIEDFILE" ]]; then
    # If the file exists, load the variable from it
    source "$NOTIFIEDFILE"
    echo -n $NOTIFIED
else
    # If the file does not exist, set variable to false
    NOTIFIED=false
fi

BATTERY=$(bluetoothctl info | awk -F '[()]' '/Battery Percentage/ {print $2}')

if [[ $NOTIFIED == true && ($BATTERY != *"10"* || $BATTERY != *"5"*) ]]; then
    NOTIFIED=false
    echo "NOTIFIED=$NOTIFIED" > $NOTIFIEDFILE
fi


if [[ $NOTIFIED == false && ($BATTERY == *"10"* || $BATTERY == *"5"*) ]]; then
    notify-send --icon=1 -t 2000 "Low Headphone Battery " $BATTERY
    NOTIFIED=true
    echo "NOTIFIED=$NOTIFIED" > $NOTIFIEDFILE
fi


echo -n $BATTERY

