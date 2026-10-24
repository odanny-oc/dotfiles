#!/bin/bash
localsend & disown
sleep 2
hyprctl dispatch "hl.dsp.window.close({window = 'class:org.localsend.localsend_app'})"
