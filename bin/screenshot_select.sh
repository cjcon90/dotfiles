#!/bin/bash

SCREENSHOT="$HOME/Pictures/screenshots/$(date "+%y%m%d%H%M%S")_select.png"

grim -g "$(slurp)" "$SCREENSHOT"
notify-send "Screenshot Captured!" "Saved to: $SCREENSHOT" --icon=dialog-information
