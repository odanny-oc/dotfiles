#!/bin/bash

MONITOR="eDP-1"
MODE="preferred"
POSITION="auto"
SCALE="1"

line=$(hyprctl monitors | awk "/transform:/")


if [[ $line == *"transform: 0"* ]]; then
  TRANSFORM=3
elif [[ $line == *"transform: 3"* ]]; then
  TRANSFORM=2
elif [[ $line == *"transform: 2"* ]]; then
  TRANSFORM=1
else
  TRANSFORM=0
fi

  if [[ $TRANSFORM == 1 ]]; then
      hyprctl keyword monitor "$MONITOR,$MODE,$POSITION,$SCALE,transform,$TRANSFORM" & ln -sf ~/.config/waybar/style_vert.css ~/.config/waybar/style.css & hyprctl keyword input:touchdevice:transform $TRANSFORM & hyprctl keyword input:tablet:transform $TRANSFORM & ln -sf ~/.config/waybar/config_vert.jsonc ~/.config/waybar/config.jsonc & bash ~/.config/hypr/scripts/waybarrs.sh
  elif [[ $TRANSFORM == 3 ]]; then
  hyprctl keyword monitor "$MONITOR,$MODE,$POSITION,$SCALE,transform,$TRANSFORM" & ln -sf ~/.config/waybar/style_vert.css ~/.config/waybar/style.css & hyprctl keyword input:touchdevice:transform $TRANSFORM & hyprctl keyword input:tablet:transform $TRANSFORM & ln -sf ~/.config/waybar/config_vert.jsonc ~/.config/waybar/config.jsonc & bash ~/.config/hypr/scripts/waybarrs.sh
  else
  hyprctl keyword monitor "$MONITOR,$MODE,$POSITION,$SCALE,transform,$TRANSFORM" & ln -sf ~/.config/waybar/style_og.css ~/.config/waybar/style.css & hyprctl keyword input:touchdevice:transform $TRANSFORM & hyprctl keyword input:tablet:transform $TRANSFORM & ln -sf ~/.config/waybar/config_og.jsonc ~/.config/waybar/config.jsonc & bash ~/.config/hypr/scripts/waybarrs.sh
  fi

done
