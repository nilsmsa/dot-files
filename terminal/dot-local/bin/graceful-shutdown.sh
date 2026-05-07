#!/bin/bash

# Ensure jq is installed for parsing Hyprland's JSON output
if ! command -v jq &> /dev/null; then
    systemctl poweroff
    exit
fi

# 1. Find the address of the current active window (the terminal/launcher running this)
ACTIVE_ADDR=$(hyprctl activewindow -j | jq -r '.address' 2>/dev/null)

# 2. Tell Hyprland to gracefully close all windows EXCEPT the active one
HYPRCMDS=$(hyprctl -j clients | jq -j --arg active "$ACTIVE_ADDR" '.[] | select(.address != $active) | "dispatch closewindow address:\(.address); "')

if [ -n "$HYPRCMDS" ]; then
    hyprctl --batch "$HYPRCMDS"
    # Give Chromium and other apps 2 seconds to write to disk and clear lockfiles
    sleep 2
fi

# 3. Safe to pull the plug now
systemctl poweroff
