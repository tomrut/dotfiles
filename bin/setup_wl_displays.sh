#!/usr/bin/env bash
outputs_num=$(swaymsg -t get_outputs | grep name | wc -l)
echo "outputsnum: $outputs_num"
[[ $outputs_num == 3 ]] && swaymsg output LVDS-1 disable

output_laptop=$(swaymsg -t get_outputs | grep LVDS-1 | wc -l)
if [[ $output_laptop == 0 ]]; then
  echo "ll $output_laptop"
  swaymsg output DP-4 pos 0 0
  swaymsg output DP-5 pos 1920 0
fi
# if [[ $outputs_num == 2 ]]; then
#   export second_output=$(swaymsg -t  get_outputs|jq -r '.[] | select(.name != "LVDS-1") | .name')
#   echo "set \$output1 $second_output" > ~/.config/sway/outputs
# else
#   echo "" > ~/.config/sway/outputs
# fi
#
# sync
