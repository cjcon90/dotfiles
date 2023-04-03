#!/bin/bash

folder=~/Pictures/screenshots

grim -g "$(slurp)" "$folder"/"$(date +%Y%m%d-%H%M%S)".png
