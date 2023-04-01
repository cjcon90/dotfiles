#!/usr/bin/env bash
# Getting the new output name
external_output=$(swaymsg -t get_outputs | jq '.[].name | select(. != "eDP-1")')
# Listing all workspaces but the first and move them to external output
swaymsg -rt get_workspaces | jq '.[]|select(.num != 1).num' | xargs -I {} swaymsg workspace number {}, move workspace to output $external_output
#!/usr/bin/env bash# Getting the new output nameexternal_output=$(swaymsg -t get_outputs | jq '.[].name | select(. != "eDP-1")')# Listing all workspaces but the first and move them to external outputswaymsg -rt get_workspaces | jq '.[]|select(.num != 1).num' | xargs -I {} swaymsg workspace number {}, move workspace to output $external_output

