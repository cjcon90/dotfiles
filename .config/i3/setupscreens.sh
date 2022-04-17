#!/bin/sh
SCREENS=$(xrandr |grep connected | grep -wv disconnected | wc -l)
echo $SCREENS
if [ $SCREENS -eq 2 ]; then
    xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-1 --off --output HDMI-2 --off --output DP-2 --primary --mode 3440x1440 --pos 1920x0 --rotate normal --output HDMI-3 --off --output DP-3 --off --output DP-4 --off
else
    xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off

fi
conky -c .conkyrc 2> /dev/null
sleep 2
/usr/bin/python3 /home/ciaranconcannon/bin/island_time.py
