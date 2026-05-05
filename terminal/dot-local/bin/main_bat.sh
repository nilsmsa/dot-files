#!/bin/bash

# Get battery info
battery_info=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)

# Extract percentage
percentage=$(echo "$battery_info" | grep -E "percentage" | awk '{print $2}' | tr -d '%')

# Extract state (charging/discharging)
state=$(echo "$battery_info" | grep -E "state" | awk '{print $2}')

# Choose icon based on state and level
if [[ "$state" == "charging" || "$state" == "fully-charged" ]]; then
    icon="󰂄"
elif [[ $percentage -ge 90 ]]; then
    icon="󰁹"
elif [[ $percentage -ge 70 ]]; then
    icon="󰂂"
elif [[ $percentage -ge 40 ]]; then
    icon="󰂀"
elif [[ $percentage -ge 20 ]]; then
    icon="󰁾"
else
    icon="󰁺"
fi

echo "$icon $percentage%"