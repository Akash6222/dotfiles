#!/bin/bash

# Function to send charging notification
send_charging_notification() {
    battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)
    notify-send "Charging" "Battery level is currently $battery_percentage%."
}

# Function to send warning notifications
send_warning_notification() {
    case "$1" in
        20)
            notify-send "Warning" "Battery level is 20%"
            warning_executed=1  # Set the warning executed flag
            ;;
        15)
            notify-send "Warning" "Battery level is 15%. Soon system will be locked."
            warning_executed=1  # Set the warning executed flag
            ;;
        10)
            notify-send "Warning" "Battery level is below 10%. Locking screen in 10s."
            ~/.config/hypr/scripts/LockScreen.sh
            warning_executed=1  # Set the warning executed flag
            ;;
    esac
}

# Function to monitor charging status
monitor_charging_status() {
    charging_stopped_notified=0
    charging_status=""
    warning_executed=0  # Flag to track whether the warning has been executed

    while true; do
        # Get the battery status (Charging or Discharging)
        battery_status=$(cat /sys/class/power_supply/BAT0/status)

        # If the battery is charging and charging notification hasn't been sent yet
        if [ "$battery_status" == "Charging" ] && [ "$charging_status" != "Charging" ]; then
            send_charging_notification
            charging_status="Charging"
            warning_executed=0  # Reset the warning executed flag
        elif [ "$battery_status" != "Charging" ]; then
            charging_status=""
        fi

        # If the battery is discharging
        if [ "$battery_status" == "Discharging" ]; then
            # Get the battery percentage
            battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)

            # Check battery level and trigger warnings if necessary
            if [ "$battery_percentage" -eq 20 ] && [ "$warning_executed" -eq 0 ]; then
                send_warning_notification 20
            elif [ "$battery_percentage" -eq 15 ] && [ "$warning_executed" -eq 0 ]; then
                send_warning_notification 15
            elif [ "$battery_percentage" -eq 10 ] && [ "$warning_executed" -eq 0 ]; then
                send_warning_notification 10
            fi
        fi

        # If the battery is not charging and charging stopped notification hasn't been sent yet
        if [ "$battery_status" == "Not charging" ] && [ "$charging_stopped_notified" -eq 0 ]; then
            # Notify once when charging stops
            battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)
            notify-send "Charging Stopped" "Charging Stopped at Battery level $battery_percentage%."
            charging_stopped_notified=1
        fi

        # Sleep for 1 minute before checking again
        #sleep 60
    done
}

# Start monitoring charging status in the background
monitor_charging_status &
