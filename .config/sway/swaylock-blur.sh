#!/bin/bash

# Get all output names and screenshot/blur each one
for output in $(swaymsg -t get_outputs -r | jq -r '.[].name'); do
  grim -o "$output" $XDG_RUNTIME_DIR/lock-$output.png
  magick $XDG_RUNTIME_DIR/lock-$output.png -blur 0x5 $XDG_RUNTIME_DIR/lock-$output.png
done

# Build swaylock command with each output's image
swaylock_cmd="swaylock -f"
for output in $(swaymsg -t get_outputs -r | jq -r '.[].name'); do
  swaylock_cmd="$swaylock_cmd -i $output:$XDG_RUNTIME_DIR/lock-$output.png"
done

$swaylock_cmd
