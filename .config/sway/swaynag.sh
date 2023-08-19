#!/usr/bin/bash

swaynag -c $HOME/.config/swaynag/config -t warning -m 'Power Menu Options' -b 'Logout' 'swaymsg exit' -b 'Suspend' 'sudo systemctl suspend' -b 'Reboot' 'sudo systemctl reboot' -b 'Shutdown' 'sudo systemctl poweroff'
