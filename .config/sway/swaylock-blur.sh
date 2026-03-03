#!/bin/bash

# Get all output names and screenshot/blur each one
for output in $(swaymsg -t get_outputs -r | jq -r '.[].name'); do
  grim -o "$output" /tmp/lock-$output.png
  magick /tmp/lock-$output.png -blur 0x5 /tmp/lock-$output.png
done

# Build swaylock command with each output's image
swaylock_cmd="swaylock"
for output in $(swaymsg -t get_outputs -r | jq -r '.[].name'); do
  swaylock_cmd="$swaylock_cmd -i $output:/tmp/lock-$output.png"
done

$swaylock_cmd
