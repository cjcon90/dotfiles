#!/bin/bash

vpn=$(nmcli connection show --active | grep ProtonVPN | awk '{print $2}')
if [ $? == '0' ]; then
  tooltip=''
  echo '{"text": " '"$vpn"' ", "tooltip": "", "class": "connected"}'
else
  echo '{"text": "", "tooltip": "", "class": "disconnected"}'
fi
