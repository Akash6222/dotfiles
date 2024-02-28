#!/bin/bash

# Battery warning script

# Flag to track if charging stopped notification has been sent
charging_stopped_notified=0
a=0

while true; do
    # Get the battery status (Charging or Discharging)
    battery_status=$(cat /sys/class/power_supply/BAT0/status)

    # Get the battery percentage
    battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)

    if [ "$battery_status" == "Discharging" ]; then
        # Reset the flag if battery is discharging
        charging_stopped_notified=0
        a=0

        # Check battery level and trigger warnings
        if [ "$battery_percentage" -eq 20 ]; then
            notify-send "Warning" "Battery level is 20%"
            sleep 120
        elif [ "$battery_percentage" -eq 15 ]; then
            notify-send "Warning" "Battery level is 15%. Soon system will be locked."
            sleep 120
        elif [ "$battery_percentage" -lt 10 ]; then
            notify-send "Warning" "Battery level is below 10%. Locking screen in 10s."
            sleep 10
            ~/.config/hypr/scripts/LockScreen.sh
        fi
    elif [ "$battery_status" == "Not charging" ] && [ "$charging_stopped_notified" -eq 0 ]; then
        # Notify once when charging stops
        notify-send "Charging Stopped" "Charging Stopped at Battery level $battery_percentage%."
        
        # Set the flag to indicate that notification has been sent
        charging_stopped_notified=1
        a=0
    
    elif [ "$battery_status" == "Charging" ] && [ "$a" -eq 0 ]; then
        notify-send "Charging"
        a=1
    fi

    # Sleep for 1 minute before checking again
    #sleep 60
done
