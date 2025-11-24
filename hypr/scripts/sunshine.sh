#!/usr/bin/env bash


SUNSHINE=$(hyprctl monitors | grep -o sunshine)

if [ $SUNSHINE = "sunshine" ]; then
    hyprctl output remove sunshine
    pkill sunshine
    notify-send -e -t 1300 -r 1 -i /usr/share/icons/hicolor/scalable/apps/sunshine.svg "Sunshine stopped"
else
    hyprctl output create headless sunshine
    sunshine &
    notify-send -e -t 1300 -r 1 -i /usr/share/icons/hicolor/scalable/apps/sunshine.svg "Sunshine started"
fi

