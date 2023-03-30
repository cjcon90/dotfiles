#!/bin/sh
SCREENS=$(xrandr |grep connected | grep -wv disconnected)
SCREENCOUNT=$(echo "$SCREENS" | wc -l)
if [ $SCREENCOUNT -eq 2 ]; then
  if grep -q "DP-3" <<< $SCREENS; then
    /bin/sh ~/.screenlayout/work_dual.sh
    echo "Setting screens for work setup"
  else
    /bin/sh ~/.screenlayout/home.sh
    echo "Setting screens for home setup"
  fi
else
  /bin/sh ~/.screenlayout/laptop.sh
  echo "Setting screens for laptop setup"
fi

DISPLAY=:0.0 feh --bg-fill Pictures/wallpapers/dracula-kraken.png
betterlockscreen -u Pictures/wallpapers/dracula-kraken.png
/usr/bin/sh /home/ciaranconcannon/.config/i3/launch-polybar.sh
