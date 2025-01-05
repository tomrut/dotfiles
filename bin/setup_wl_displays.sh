#!/usr/bin/env bash
[[ $(swaymsg -t get_outputs  | grep name | wc -l) == 3 ]] && swaymsg output LVDS-1 disable

