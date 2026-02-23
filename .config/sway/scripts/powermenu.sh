#!/usr/bin/env bash
options="⏻   PowerOff\n   Reboot\n󰤄   Sleep\n󰌾   Lock\n󰍃   Logout"

chosen=$(echo -e $options | wmenu -p "Power:" -i)

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
