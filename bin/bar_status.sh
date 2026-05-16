#!/usr/bin/env bash

date=$(date +%d\ %B\ %Y\ ❙\ \ \ %H:%M)

battery() {
  local bat_no=$1
  prct=$(cat "/sys/class/power_supply/BAT${bat_no}/capacity")
  chrg=$(cat "/sys/class/power_supply/BAT${bat_no}/status")
  icon=" "
  case $chrg in
  "Charging")
    icon="󰂄"
    ;;
  "Not charging")
    icon="󰠑"
    ;;
  "Unknown")
    icon=""
    ;;
  "Full")
    icon="⚡"
    ;;
  esac
  echo "${icon}  ${prct}% ${chrg} "
}

bat0=$(battery 0)
bat1=$(battery 1)
cpu_temp="$(awk '{x += $1} END{ printf "%.0f", x / NR / 1000}' /sys/class/thermal/thermal_zone*/temp)°C"
mem=$(free -m | grep Pami | awk '{print ($3/$2)*100}')
mem_rounded=$(printf "%.0f" "${mem/./,}")
cpu_util=$(vmstat 1 2 | tail -1 | awk '{print 100 - $15""}')
sound_volume=$(pulsemixer --get-volume | awk '{print $2}')
# sound_volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d : -f 2)

echo "❙ 💎${cpu_util}% ❙  $mem_rounded% ❙ ⚡${cpu_temp} ❙ 🎧${sound_volume}% ❙ ${bat0} ❙ ${bat1} ❙ ${date} ❙"
