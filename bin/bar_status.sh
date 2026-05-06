#!/usr/bin/env bash

date=$(date +%d-%B-%Y\ %H:%M)
bat0=$(cat /sys/class/power_supply/BAT0/capacity)
bat1=$(cat /sys/class/power_supply/BAT1/capacity)
cpu_temp="$(awk '{x += $1} END{ printf "%.2f", x / NR / 1000}' /sys/class/thermal/thermal_zone*/temp)°C"

echo "TEMP:${cpu_temp}  BAT0: ${bat0}% BAT1: ${bat1}% ${date}"
