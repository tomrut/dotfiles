#!/usr/bin/env bash
# Get available windows
windows=$(swaymsg -t get_tree | jq -r '.nodes[1].nodes[].nodes[] | .. | (.id|tostring) + " " + .name?' | grep -e "[0-9]* .")

# Select window with rofi
selected=$(echo "$windows" | wofi -W 60% -d -i --hide-scroll -p "Switch window:" | awk '{print $1}')

# Tell sway to focus said window
swaymsg [con_id="$selected"] focus
