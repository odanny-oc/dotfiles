#!/bin/bash
localsend & disown
sleep 2
hyprctl dispatch closewindow class:localsend 
