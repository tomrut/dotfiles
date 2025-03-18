#!/usr/bin/env bash
options="⏻   PowerOff\n   Reboot\n󰤄   Sleep\n󰌾   Lock\n󰍃   Logout"

choice=$(echo -e "$options" | fuzzel --dmenu --prompt="Select Power Option: ")

case "$choice" in
    "⏻   PowerOff")
        systemctl poweroff
        ;;
    "   Reboot")
        systemctl reboot
        ;;
    "󰤄   Sleep")
        systemctl suspend
        ;;
    "󰌾   Lock")
      gtklock
        ;;
    "󰍃   Logout")
        swaymsg exit
        ;;
    *)
        echo "No valid option selected."
        ;;
esac

