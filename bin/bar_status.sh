#!/usr/bin/env bash

date=$(date +%d-%B-%Y\ %H:%M)
bat0=$(cat /sys/class/power_supply/BAT0/capacity)
bat1=$(cat /sys/class/power_supply/BAT1/capacity)
cpu_temp="$(awk '{x += $1} END{ printf "%.2f", x / NR / 1000}' /sys/class/thermal/thermal_zone*/temp)°C"
mem=$(free -m | grep Pami | awk '{print ($3/$2)*100}')
mem_rounded=$(printf "%.0f\n" $mem)
cpu_util=$(vmstat 1 2 | tail -1 | awk '{print 100 - $15""}')

echo "CPU: ${cpu_util}%  MEM: $mem_rounded%  TEMP: ${cpu_temp}  BAT0: ${bat0}%  BAT1: ${bat1}%  ${date}"
