#!/usr/bin/env bash
# battery-notify.sh

icon_path="$HOME/.config/icons"

BAT=$(ls -d /sys/class/power_supply/BAT* 2>/dev/null | head -n1)
[[ -z $BAT ]] && { echo "No battery found" >&2; exit 1; }

INTERVAL=60                 # seconds between checks
LOW=(5 10 20)               # discharging thresholds (ascending)
HIGH=(90 100)               # charging thresholds (ascending)

declare -A sent

notify() { notify-send -e -i $1 -t 4000 -u "$2" "$3" "$4"; }

while true; do
    cap=$(<"$BAT/capacity")
    status=$(<"$BAT/status")

    if [[ $status == Discharging ]]; then
        # charge alerts re-arm once unplugged
        unset 'sent[90]' 'sent[100]'

        # find the lowest threshold we've crossed
        for t in "${LOW[@]}"; do
            if (( cap <= t )); then
                if [[ -z ${sent[$t]} ]]; then
                    urgency=normal bat=bat_mid.png; (( t <= 10 )) && { urgency=critical; bat=bat_low.png; }
                    notify "/home/danny/.config/icons/$bat" "$urgency" "Battery low: ${cap}%" "Plug in the charger."
                    # mark this and all higher thresholds as sent
                    for h in "${LOW[@]}"; do (( h >= t )) && sent[$h]=1; done
                fi
                break
            fi
        done
    else
        # plugged in: low alerts re-arm
        unset 'sent[5]' 'sent[10]' 'sent[20]'

        for t in "${HIGH[@]}"; do
            if (( cap >= t )) || { (( t == 100 )) && [[ $status == Full ]]; }; then
                if [[ -z ${sent[$t]} ]]; then
                    notify "/home/danny/.config/icons/bat_full.png" normal "Battery at ${cap}%" "Charged to ${t}%."
                    for h in "${HIGH[@]}"; do (( h <= t )) && sent[$h]=1; done
                fi
            fi
        done
    fi

    sleep "$INTERVAL"
done
