#!/bin/bash

# 1. Identify the user
USER=$(loginctl list-users --no-legend | awk '{print $2}')
USER_ID=$(id -u "$USER")

# 2. Get the Hyprland Instance Signature (crucial for hyprctl)
# This looks for the active socket in your user's temporary directory
HYPR_SIG=$(ls /run/user/1000/hypr | awk 'NR==3')

# 3. Define the environment string to keep the command clean
HYPR_ENV="DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$USER_ID/bus HYPRLAND_INSTANCE_SIGNATURE=$HYPR_SIG"

# 4. Run the commands as your user
sudo -u "$USER" env $HYPR_ENV notify-send -t 1300 -e "Tablet Macros Active"

# 5. Run xremap via hyprctl dispatch
# We use 'hyprctl dispatch exec' so the process starts inside your session environment
# sudo -u danny env HYPRLAND_INSTANCE_SIGNATURE="$HYPR_SIG" /usr/bin/hyprctl dispatch exec /usr/bin/xremap /home/danny/.config/xremap/config.yml

# Log for debugging
echo "USB device connected at $(date) for user $USER" >> /tmp/usb-log.txt
