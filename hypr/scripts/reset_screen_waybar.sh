#!/bin/bash

MONITOR="eDP-1"
MODE="preferred"
POSITION="auto"
SCALE="1"
TRANSFORM=0

hyprctl keyword monitor "$MONITOR,$MODE,$POSITION,$SCALE,transform,$TRANSFORM" & ln -sf ~/.config/waybar/style_og.css ~/.config/waybar/style.css & hyprctl keyword input:touchdevice:transform $TRANSFORM & hyprctl keyword input:tablet:transform $TRANSFORM & ln -sf ~/.config/waybar/config_og.jsonc ~/.config/waybar/config.jsonc & killall -SIGUSR2 waybar
