#!/bin/bash
# Session actions menu (rofi).

entries=(
  $'<span font_size="26pt" foreground="#bd93f9">󰌾</span>\nLock'
  $'<span font_size="26pt" foreground="#8be9fd">󰍃</span>\nLogout'
  $'<span font_size="26pt" foreground="#f1fa8c">󰤄</span>\nSuspend'
  $'<span font_size="26pt" foreground="#ffb86c">󰜉</span>\nReboot'
  $'<span font_size="26pt" foreground="#ff5555">󰐥</span>\nShutdown'
)

choice=$(IFS='|'; printf '%s' "${entries[*]}" |
  rofi -dmenu -sep '|' -eh 2 -markup-rows -p Power \
    -mesg "up $(uptime -p | sed 's/^up //')" -theme ~/.config/rofi/power.rasi)

case "$choice" in
  *Lock) swaylock -f ;;
  *Logout) swaymsg exit ;;
  *Suspend) systemctl suspend ;;
  *Reboot) systemctl reboot ;;
  *Shutdown) systemctl poweroff ;;
esac
