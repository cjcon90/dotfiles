#!/bin/bash

SCREENSHOT_URL=Pictures/screenshots/"$(date "+%y%m%d%H%M%S")"_select.png

maim -s ~/"$SCREENSHOT_URL"

notify-send "Screenshot Captured!" "Saved to: $SCREENSHOT_URL" --icon=dialog-information
