#!/bin/bash
# Searchable list of sway keybindings, read from the live config.

grep -E '^bindsym ' ~/.config/sway/config |
  sed -E 's/^bindsym (--[a-z-]+ )*//; s/ exec / /' |
  awk '{
    key = $1; $1 = ""
    gsub(/\$mod/, "Alt", key); gsub(/\$left/, "h", key); gsub(/\$down/, "j", key)
    gsub(/\$up/, "k", key); gsub(/\$right/, "l", key)
    printf "%-30s %s\n", key, substr($0, 2)
  }' |
  rofi -dmenu -i -p "Keys" >/dev/null
