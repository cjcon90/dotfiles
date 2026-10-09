#!/bin/bash
# DO A BARREL ROLL: spin the focused screen 360° while the keyboard goes full rainbow spiral

exec 9>/tmp/barrel-roll.lock
flock -n 9 || exit

out=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused).name')
orig=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused).transform')
state=/var/lib/kbd-rainbow/state.json
saved=$(mktemp)
cp "$state" "$saved"

# Big centred banner (floated by the app_id="barrel-roll" rule in sway config); it spins with the screen
alacritty --class barrel-roll -o font.size=56 -e bash -c '
    sleep 0.2; tput civis; text="DO A BARREL ROLL!"
    printf "%*s" $(( $(tput lines) / 2 )) "" | tr " " "\n"
    printf "%*s" $(( ($(tput cols) + ${#text}) / 2 )) "$text"
    sleep 10' &
banner=$!
sleep 1
/usr/local/bin/kbd-rainbow --mode spiral --brightness 1 --speed 1

for _ in 1 2 3 4; do
    sleep 0.4
    swaymsg -q output "$out" transform 90 clockwise
done
swaymsg -q output "$out" transform "$orig"
kill $banner

sleep 1
install -m 664 "$saved" "$state.barrel-roll"
mv -f "$state.barrel-roll" "$state"
rm -f "$saved"
