#!/usr/bin/env bash
outputs_num=$(swaymsg -t get_outputs  | grep name | wc -l)
echo "outputsnum: $outputs_num"
[[ $outputs_num == 3 ]] && swaymsg output LVDS-1 disable
if [[ $outputs_num == 2 ]]; then 
  export second_output=$(swaymsg -t  get_outputs|jq -r '.[] | select(.name != "LVDS-1") | .name')
  echo "set \$output1 $second_output" > ~/.config/sway/outputs
  sync
fi

