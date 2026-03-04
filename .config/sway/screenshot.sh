#!/bin/bash

folder=~/Pictures/screenshots
file="$folder/$(date +%Y%m%d-%H%M%S).png"

grim "$file" && notify-send "Screenshot saved" "$file"
