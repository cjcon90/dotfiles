#!/usr/bin/bash

swaynag -c $HOME/.config/swaynag/config -t warning -m 'Power Menu Options' \
  -b 'Logout' 'swaymsg exit' \
  -b 'Suspend' 'systemctl suspend' \
  -b 'Reboot' 'systemctl reboot' \
  -b 'Shutdown' 'systemctl poweroff'
