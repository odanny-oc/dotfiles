#!/bin/bash

icon_path="$HOME/.config/icons"

wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+

VOLUME=$(wpctl get-volume @DEFAULT_SINK@ | grep -oP '(?<=\.)\d+')

if [[ $VOLUME == *"00"* ]]; then
    CHECK=$(wpctl get-volume @DEFAULT_SINK@ | grep -oP '\d(\.)')
    if [[ $CHECK == *"1."* ]]; then
        VOLUME='100'
    else
        VOLUME='0'
    fi
fi

MUTE=$(wpctl get-volume @DEFAULT_SINK@ | grep -oP 'MUTED')

if [[ $MUTE == *"MUTED"* ]]; then
    notify-send --replace-id=4 -i "$icon_path/volume-up.png" -e -t 1300 " Volume $VOLUME% $MUTE"
else
    notify-send --replace-id=4 -i "$icon_path/volume-up.png" -e -t 1300 " Volume $VOLUME%"
fi

