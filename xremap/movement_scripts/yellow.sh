#!/bin/bash

RETURNX=$(hyprctl cursorpos | awk -F , '{print $1}')
RETURNY=$(hyprctl cursorpos | awk '{print $2}')

ydotool mousemove -a 900 152

ydotool click 0xC0

# ydotool mousemove -a 897 187
#
# ydotool click 0xC0

ydotool mousemove -a $RETURNX $RETURNY
