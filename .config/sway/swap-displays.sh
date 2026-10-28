#!/usr/bin/env bash
# Swap all workspaces between the laptop screen and the external monitor.

ext=$(swaymsg -t get_outputs | jq -r '.[] | select(.active and .name != "eDP-1") | .name' | head -1)
[ -n "$ext" ] || exit 0

workspaces=$(swaymsg -t get_workspaces)
focused=$(jq -r '.[] | select(.focused).name' <<<"$workspaces")
visible=$(jq -r '.[] | select(.visible and (.focused | not)).name' <<<"$workspaces")
moves=$(jq -r --arg ext "$ext" '[sort_by(.output != "eDP-1")[]
  | "workspace \"\(.name)\"; move workspace to output \(if .output == "eDP-1" then $ext else "eDP-1" end)"]
  | join("; ")' <<<"$workspaces")

# Focus stays on the same screen, now showing the other screen's workspace
swaymsg -q "$moves; workspace \"$focused\"; workspace \"$visible\""
