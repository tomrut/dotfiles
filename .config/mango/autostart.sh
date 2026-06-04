#!/usr/bin/env bash
foot --server >/dev/null 2>&1 &
swayidle -w before-sleep "swaylock -f -c 000000" timeout 180 'mmsg -d toggle_monitor,LVDS-1 && mmsg -d toggle_monitor,DP-3' resume 'mmsg -d toggle_monitor,LVDS-1 && mmsg -d toggle_monitor,DP-3' timeout 1800 "systemctl suspend" timeout 900 'mmsg -d toggle_monitor,LVDS-1 && mmsg -d toggle_monitor,DP-3  && swaylock -f -c 000000' resume 'mmsg -d enable_monitor,LVDS-1 && mmsg -d enable_monitor,DP-3' &
