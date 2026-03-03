#!/bin/bash

plugged=$(cat /sys/class/power_supply/AC/online)
charge=$(cat /sys/class/power_supply/BAT0/capacity)
if [[ plugged -eq "1" ]]; then
  exit 0
fi

if [[ $charge -lt 5 ]]; then
  notify-send "Battery less than 5%" --urgency=critical
  exit 0
fi

if [[ $charge -lt 10 ]]; then
  notify-send "Battery less than 10%" --urgency=normal
  exit 0
fi
