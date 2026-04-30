#!/bin/bash

SCREENSHOT="$HOME/Pictures/screenshots/$(date "+%y%m%d%H%M%S")_full.png"

grim "$SCREENSHOT"
notify-send "Screenshot Captured!" "Saved to: $SCREENSHOT" --icon=dialog-information
