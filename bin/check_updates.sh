#!/usr/bin/env bash

# check for pending updates
# - heavily inspired by this post: https://blog.tjll.net/previewing-nixos-system-updates/
nixos_current_system="/run/current-system"
nixos_system="/nix/var/nix/profiles/system"
pending_updates="uknown"
if [ -d "$nixos_current_system" ] && [ -d "$nixos_system" ]; then
  nixos_current_system_hash="$(basename $(readlink -f "$nixos_current_system") | cut -d- -f1)"
  nixos_system_hash="$(basename $(readlink -f "$nixos_system") | cut -d- -f1)"
  if [ "$nixos_current_system_hash" != "$nixos_system_hash" ]; then
    nvd_output_file="/tmp/.nvd-${nixos_current_system_hash}-${nixos_system_hash}"
    nvd_command="nvd diff "$nixos_current_system" "$nixos_system""
    if [ -x "$(command -v nvd)" ] >/dev/null 2>&1; then
      nvd_diff="$(eval "$nvd_command")"
    else
      nvd_diff="$(nix-shell --quiet -p nvd --command "$nvd_command")"
    fi

    echo "$nvd_diff" >"$nvd_output_file"

    if [ -r "$nvd_output_file" ]; then
      pending_updates="$(cat "$nvd_output_file" | tail -n +3 | grep -E "^\[(U|D|C).\]" | sed -e 's/\\/\\\\/g' -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g')"
    else
      exit 0
    fi

    rm -f "$nvd_output_file"
  else
    pending_updates="no updates available"
  fi
else
  exit 0
fi
# check if a reboot is required
priority="normal"
subtitle=""
if [ "$pending_updates" != "no updates available" ]; then
  if diff <(readlink /run/booted-system/{initrd,kernel,kernel-modules}) <(readlink /nix/var/nix/profiles/system/{initrd,kernel,kernel-modules}) >/dev/null 2>&1; then
    subtitle=", reboot normal 👌 "
    priority="normal"
  else
    subtitle=", reboot critical   "
    priority="critical"
  fi
fi

notify-send -u ${priority} "System updated ${subtitle}" "${pending_updates} "

echo "{\"text\": \"System updated $subtitle\",\"tooltip\":$pending_updates}"
