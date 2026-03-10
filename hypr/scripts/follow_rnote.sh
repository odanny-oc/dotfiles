#!/usr/bin/env bash

CLASS="com.github.flxzt.rnote"
INTERVAL=0.3

while true; do
    win=$(hyprctl clients -j | jq -c '.[] | select(.class | ascii_downcase == "'"$CLASS"'")' | head -n1)

    if [ -n "$win" ]; then
        x=$(echo "$win" | jq '.at[0]')
        y=$(echo "$win" | jq '.at[1]')
        w=$(echo "$win" | jq '.size[0]')
        h=$(echo "$win" | jq '.size[1]')

        hyprctl keyword input:tablet:region_position "$x $y" >/dev/null
        hyprctl keyword input:tablet:region_size "$w $h" >/dev/null
    fi

    sleep $INTERVAL
done
