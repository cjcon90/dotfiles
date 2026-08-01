#!/bin/bash
# Quick WiFi connect menu (rofi), replacement for the nm-applet tray dropdown.

active_ssid=$(nmcli -t -f active,ssid dev wifi | awk -F: '$1=="yes"{print $2}')

mapfile -t lines < <(
  nmcli -t -f ssid,security,signal dev wifi list --rescan yes |
    awk -F: '!seen[$1]++ && $1!=""' |
    sort -t: -k3 -rn
)

menu=""
for line in "${lines[@]}"; do
  ssid="${line%%:*}"
  rest="${line#*:}"
  security="${rest%%:*}"
  signal="${rest#*:}"
  marker="  "
  [[ "$ssid" == "$active_ssid" ]] && marker="* "
  lock=""
  [[ -n "$security" && "$security" != "--" ]] && lock=" 󰌾"
  menu+="${marker}${ssid} (${signal}%)${lock}\n"
done
menu+="---\n"
menu+="󰖩 Toggle WiFi radio\n"
menu+="Edit connections...\n"

choice=$(echo -e "$menu" | rofi -dmenu -p "WiFi" | sed 's/^[* ]*//')
[[ -z "$choice" ]] && exit 0

case "$choice" in
  "Edit connections..."*)
    exec nm-connection-editor
    ;;
  "󰖩 Toggle WiFi radio"*)
    if [[ "$(nmcli radio wifi)" == "enabled" ]]; then
      nmcli radio wifi off
      notify-send "WiFi" "Radio disabled"
    else
      nmcli radio wifi on
      notify-send "WiFi" "Radio enabled"
    fi
    exit 0
    ;;
  ---*)
    exit 0
    ;;
esac

ssid=$(echo "$choice" | sed -E 's/ \([0-9]+%\)( 󰌾)?$//')

if [[ "$ssid" == "$active_ssid" ]]; then
  nmcli con down id "$ssid" && notify-send "WiFi" "Disconnected from $ssid"
  exit 0
fi

if nmcli -t -f NAME connection show | grep -qxF "$ssid"; then
  if nmcli con up id "$ssid" &>/tmp/wifi-menu-err; then
    notify-send "WiFi" "Connected to $ssid"
  else
    notify-send "WiFi" "Failed to connect to $ssid: $(cat /tmp/wifi-menu-err)"
  fi
  exit 0
fi

security=$(nmcli -t -f ssid,security dev wifi list | awk -F: -v s="$ssid" '$1==s{print $2; exit}')
if [[ -n "$security" && "$security" != "--" ]]; then
  password=$(rofi -dmenu -password -p "Password for $ssid")
  [[ -z "$password" ]] && exit 0
  if nmcli dev wifi connect "$ssid" password "$password" &>/tmp/wifi-menu-err; then
    notify-send "WiFi" "Connected to $ssid"
  else
    notify-send "WiFi" "Failed to connect to $ssid: $(cat /tmp/wifi-menu-err)"
  fi
else
  if nmcli dev wifi connect "$ssid" &>/tmp/wifi-menu-err; then
    notify-send "WiFi" "Connected to $ssid"
  else
    notify-send "WiFi" "Failed to connect to $ssid: $(cat /tmp/wifi-menu-err)"
  fi
fi
