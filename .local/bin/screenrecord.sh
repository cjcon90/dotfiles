#!/bin/bash

folder=~/Videos/screenrecordings

if pkill -INT -x wf-recorder; then
    notify-send -t 3000 "Screen recording saved" "$folder"
    exit
fi

if [ "$1" = select ]; then
    geometry=$(slurp) || exit
    target=(-g "$geometry")
else
    target=(-o "$(swaymsg -t get_outputs | jq -r '.[] | select(.focused).name')")
fi

mkdir -p "$folder"
notify-send -t 1500 "Screen recording started" "Press M2 again to stop"
wf-recorder "${target[@]}" -f "$folder/$(date +%Y%m%d-%H%M%S).mp4"
