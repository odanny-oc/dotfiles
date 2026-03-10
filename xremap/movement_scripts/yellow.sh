#!/bin/bash

RETURNX=$(hyprctl cursorpos | awk -F , '{print $1}')
RETURNY=$(hyprctl cursorpos | awk '{print $2}')

ydotool mousemove -a 901 135

ydotool click 0xC0

ydotool mousemove -a $RETURNX $RETURNY
