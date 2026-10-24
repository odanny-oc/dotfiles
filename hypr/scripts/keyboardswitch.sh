!#/bin/bash

hyprctl switchxkblayout all next

KEYBOARD=$(hyprctl -j devices | awk -F':' '/active_keymap/ {gsub(/^[ \t"]+|[",]+$/, "", $2); print $2; exit}')

notify-send -i keyboard --replace-id=6 -e -t 1300 "Keyboard Layout $KEYBOARD"
