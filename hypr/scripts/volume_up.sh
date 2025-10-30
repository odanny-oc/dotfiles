#!/bin/bash

wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+

VOLUME=$(wpctl get-volume @DEFAULT_SINK@ | grep -oP '(?<=\.)\d+')

if [[ $VOLUME == *"00"* ]]; then
    VOLUME='100'
fi

MUTE=$(wpctl get-volume @DEFAULT_SINK@ | grep -oP 'MUTED')

if [[ $MUTE == *"MUTED"* ]]; then
    notify-send --icon==1 -e -t 1300 "Volume $VOLUME% $MUTE"
else
    notify-send --icon==1 -e -t 1300 "Volume $VOLUME%"
fi

