#!/bin/bash

# Battery warning script

while true; do
    # Get the battery status (Charging or Discharging)
    battery_status=$(cat /sys/class/power_supply/BAT0/status)

    if [ "$battery_status" == "Discharging" ]; then
        # Get the battery percentage
        battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)

        # Check battery level and trigger warnings
        if [ "$battery_percentage" -eq 20 ]; then
            notify-send "Warning" "Battery level is 20%"
        elif [ "$battery_percentage" -eq 15 ]; then
            notify-send "Warning" "Battery level is 15%. System will be pushed to sleep soon."
        elif [ "$battery_percentage" -lt 10 ]; then
            notify-send "Warning" "Battery level is below 10%. Locking screen in 10s."
            sleep 10
            ~/.config/hypr/scripts/LockScreen.sh
        fi
    fi

    # Sleep for 1 minute before checking again
    #sleep 60
done
