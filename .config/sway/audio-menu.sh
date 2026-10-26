#!/bin/bash
# Audio output picker (rofi).

current=$(wpctl inspect @DEFAULT_AUDIO_SINK@ | awk 'NR == 1 { sub(",", "", $2); print $2 }')

# Current output first
mapfile -t sinks < <(pw-dump | jq -r --argjson cur "$current" '[.[] | select(.info.props["media.class"] == "Audio/Sink")]
  | sort_by(.id != $cur)[] | "\(.id)\t\(.info.props["node.description"])\t\(.info.props["device.api"] // "")"')

rows=()
for i in "${!sinks[@]}"; do
  IFS=$'\t' read -r id name api <<<"${sinks[$i]}"
  case "$api:$name" in
    bluez5:*) icon=󰋋 ;;
    *HDMI* | *DisplayPort*) icon=󰍹 ;;
    *) icon=󰓃 ;;
  esac
  mark=""
  [ "$id" = "$current" ] && mark="  ✓"
  rows+=("$icon  $name$mark")
done

choice=$(printf '%s\n' "${rows[@]}" |
  rofi -dmenu -i -format i -p Audio -theme ~/.config/rofi/menu.rasi)
[ -n "$choice" ] || exit 0

wpctl set-default "${sinks[$choice]%%$'\t'*}"
