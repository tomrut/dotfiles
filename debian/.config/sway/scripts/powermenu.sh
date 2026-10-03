#!/usr/bin/env bash
options="Shutdown\nReboot\nLock\nSleep\nLogout"

# -i makes it case-insensitive, -p adds a prompt
chosen=$(echo -e $options | wmenu -p "Power:" -i)

case "$chosen" in
"Shutdown") systemctl poweroff ;;
"Reboot") systemctl reboot ;;
"Lock") swaylock -f -c 000000 ;;
"Sleep") systemctl suspend ;;
"Logout") swaymsg exit ;;
esac
