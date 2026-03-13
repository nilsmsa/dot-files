#!/bin/bash

DEVICE="/org/freedesktop/UPower/devices/battery_hidpp_battery_0"

# Check if device exists
if ! upower -i "$DEVICE" &>/dev/null; then
    echo "󰂲"  # Disconnected symbol
    exit 0
fi

# Get device info
info=$(upower -i "$DEVICE")

# Check if device is disconnected
icon_name=$(echo "$info" | grep -E "icon-name:" | awk '{print $2}')
if [[ "$icon_name" == "'battery-missing-symbolic'" ]]; then
    # Device might have moved to _1, check serial
    DEVICE_1="/org/freedesktop/UPower/devices/battery_hidpp_battery_1"
    if upower -i "$DEVICE_1" &>/dev/null; then
        info_1=$(upower -i "$DEVICE_1")
        serial_0=$(echo "$info" | grep -E "serial:" | awk '{print $2}')
        serial_1=$(echo "$info_1" | grep -E "serial:" | awk '{print $2}')
        
        # If serials match, use info from _1
        if [[ -n "$serial_0" && "$serial_0" == "$serial_1" ]]; then
            DEVICE="$DEVICE_1"
            info="$info_1"
        else
            echo "󰂲"  # Disconnected symbol
            exit 0
        fi
    else
        echo "󰂲"  # Disconnected symbol
        exit 0
    fi
fi

# Get percentage
percentage=$(echo "$info" | grep -E "percentage" | awk '{print $2}' | tr -d '%')

# Get state
state=$(echo "$info" | grep -E "state:" | awk '{print $2}')

# Get model name
model=$(echo "$info" | grep -E "model:" | sed 's/.*model:\s*//')

# Determine icon based on state and percentage
if [[ "$state" == "charging" || "$state" == "fully-charged" ]]; then
    icon="󰂄"
elif [ "$percentage" -ge 80 ]; then
    icon="󰂂"
elif [ "$percentage" -ge 60 ]; then
    icon="󰂀"
elif [ "$percentage" -ge 40 ]; then
    icon="󰁾"
elif [ "$percentage" -ge 20 ]; then
    icon="󰁼"
else
    icon="󰁺"
fi

echo "$model $icon $percentage%"