#!/bin/bash

status=$(protonvpn status | grep "Status:" | awk '{print $2}')
server=$(protonvpn status | grep "Server:" | awk '{print $2}')
country=$(protonvpn status | grep "Country:" | awk '{print $2}')
ip=$(protonvpn status | grep "IP:" | awk '{print $2}')
protocol=$(protonvpn status | grep "Protocol:" | awk '{print $2}')
kill_switch=$(protonvpn status | grep "Kill Switch:" | awk '{print $3}')

if [ $status == 'Connected' ]; then
  tooltip="Country: $country\nIP: $ip\nProtocol: $protocol\nKill Switch: $kill_switch"
  echo '{"text": "'"$server"'", "tooltip": "'"$tooltip"'", "class": "connected"}'
else
  echo '{"text": "", "tooltip": "", "class": "disconnected"}'
fi
