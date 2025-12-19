!#/bin/bash

ICON_PATH=$HOME/.config/icons
CHECK=$(hyprctl monitors | grep -oP sunshine_1)

if [[ $CHECK == *"sunshine_1"* ]]; then
    hyprctl output remove sunshine_1 && notify-send -i "$ICON_PATH/monitor.png" --replace-id=9 -t 1400 -e " Sunshine headless monitor removed" && pkill sunshine & notify-send -i "sunshine" --replace-id=2 -t 1400 -e "Sunshine stopped"
else
    hyprctl output create headless sunshine_1 && notify-send -i "$ICON_PATH/monitor.png" --replace-id=9 -t 1400 -e " Sunshine headless monitor added" && sunshine & notify-send -i "sunshine" --replace-id=2 -t 1400 -e "Sunshine started"
fi

