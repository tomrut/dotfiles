#!/usr/bin/env bash
options="⏻   PowerOff\n   Reboot\n󰤄   Sleep\n󰌾   Lock\n󰍃   Logout"

choice=$(echo -e "$options" | fuzzel -w 15 -l 6 -a top-right --dmenu --prompt="Select Power Option: ")

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
  swaylock -f -c 000000
  ;;
"󰍃   Logout")
  swaymsg exit
  ;;
*)
  echo "No valid option selected."
  ;;
esac
