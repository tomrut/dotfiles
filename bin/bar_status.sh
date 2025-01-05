#!/usr/bin/env bash

date=$(date +%d-%B-%Y\ %H:%M)
bat0=$(cat /sys/class/power_supply/BAT0/capacity)
bat1=$(cat /sys/class/power_supply/BAT1/capacity)

echo "BAT0: ${bat0}% BAT1: ${bat1}% ${date}"
