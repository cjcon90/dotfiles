#!/bin/bash

cmd="protonvpn-cli status"
status=$($cmd)

if [[ $status == *"No active Proton VPN connection"* ]]; then
  echo '{"text": "", "tooltip": "", "class": "disconnected"}'
else
  server=$(echo "$status" | grep "Server:" | awk '{print $2}')
  country=$(echo "$status" | grep "Country:" | awk '{print $2}')
  ip=$(echo "$status" | grep "IP:" | awk '{print $2}')
  protocol=$(echo "$status" | grep "Protocol:" | awk '{print $2}')
  kill_switch=$(echo "$status" | grep "Kill switch:" | awk '{print $3}')
  tooltip="Country: $country\nIP: $ip\nProtocol: $protocol\nKill Switch: $kill_switch"
  echo '{"text": " '"$server"' ", "tooltip": "'"$tooltip"'", "class": "connected"}'
fi
