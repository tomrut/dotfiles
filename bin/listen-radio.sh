#!/usr/bin/env bash
last=""

mpg123 "$1" 2>&1 |
  grep --line-buffered "ICY-META" |
  sed -u -n "s/.*StreamTitle='\([^']*\)'.*/\1/p" |
  while read -r title; do
    if [[ -n "$title" && "$title" != "$last" ]]; then
      notify-send "Now Playing" "$title"
      echo "Playing $title"
      last="$title"
    fi
  done
