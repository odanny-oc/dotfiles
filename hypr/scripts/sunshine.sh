#!/usr/bin/env bash


SUNSHINE=$(hyprctl monitors | grep -o SUNSHINE)

if [ $SUNSHINE = "SUNSHINE" ]; then
    hyprctl output remove SUNSHINE
    pkill sunshine
    notify-send -e -t 1300 -r 1 -i /usr/share/icons/hicolor/scalable/apps/sunshine.svg "Sunshine stopped"
else
    hyprctl output create headless SUNSHINE
    sunshine &
    notify-send -e -t 1300 -r 1 -i /usr/share/icons/hicolor/scalable/apps/sunshine.svg "Sunshine started"
fi

