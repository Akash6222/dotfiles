#!/bin/bash

# Function to send notifications
send_notification() {
    notify-send "$1" "$2"
}

# Function to execute warning and update flag
execute_warning() {
    send_notification "Warning" "$2"
    eval "warning_${1}_executed=1"  # Update the corresponding warning executed flag
}

# Initialize variables to track warning status and notification state
charging_stopped_notified=0
warning_20_executed=0
warning_15_executed=0
warning_10_executed=0
notification_state=0  # 0: Not notified, 1: Discharging, 2: Charging

# Initial battery status and percentage
initial_battery_status=$(cat /sys/class/power_supply/BAT0/status)
prev_battery_status="$initial_battery_status"
prev_battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)

# Check if the battery is charging or discharging on script startup
if [ "$initial_battery_status" == "Charging" ]; then
    notification_state=2  # Set notification state to 2 if charging
elif [ "$initial_battery_status" == "Discharging" ]; then
    notification_state=1  # Set notification state to 1 if discharging
fi

# Monitor battery status changes
while true; do
    battery_status=$(cat /sys/class/power_supply/BAT0/status)
    battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)

    # Check if battery status or percentage has changed
    if [ "$battery_status" != "$prev_battery_status" ] || [ "$battery_percentage" != "$prev_battery_percentage" ]; then
        prev_battery_status="$battery_status"
        prev_battery_percentage="$battery_percentage"

        # Check if the battery is charging
        if [ "$battery_status" == "Charging" ]; then
            if [ "$notification_state" -ne 2 ]; then
                send_notification "Charging" "Battery level is currently $battery_percentage%."
                notification_state=2
            fi
            # Reset warning flags when charging starts
            charging_stopped_notified=0
            warning_20_executed=0
            warning_15_executed=0
            warning_10_executed=0
        fi

        # Check if the battery is discharging
        if [ "$battery_status" == "Discharging" ]; then
            if [ "$notification_state" -ne 1 ]; then
                send_notification "Discharging" "Battery level is currently $battery_percentage%."
                notification_state=1
            fi
            # Execute warnings based on battery percentage and flags
            #if [ "$charging_stopped_notified" -eq 0 ]; then
            #    send_notification "Charging Stopped" "Charging Stopped at Battery level $battery_percentage%."
            #   charging_stopped_notified=1
            if [ "$battery_percentage" -eq 20 ] && [ "$warning_20_executed" -eq 0 ]; then
                execute_warning 20 "Battery level is 20%"
            elif [ "$battery_percentage" -eq 15 ] && [ "$warning_15_executed" -eq 0 ]; then
                execute_warning 15 "Battery level is 15%. Soon system will be locked."
            elif [ "$battery_percentage" -eq 10 ] && [ "$warning_10_executed" -eq 0 ]; then
                execute_warning 10 "Battery level is below 10%. Locking screen in 10s."
                ~/.config/hypr/scripts/LockScreen.sh
            fi
        fi

        # Check if charging has stopped
        if [ "$battery_status" == "Not charging" ] && [ "$charging_stopped_notified" -eq 0 ]; then
            notification_state=0  # Reset notification state
            send_notification "Charging Stopped" "Charging Stopped at Battery level $battery_percentage%."
            charging_stopped_notified=1
        fi
    fi

    # Sleep for 1 second before checking again
    sleep 1
done
