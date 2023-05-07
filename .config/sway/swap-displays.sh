#!/usr/bin/env bash
# Listing all workspaces but the first and move them to external output
# swaymsg -rt get_workspaces | jq '.[]|select(.num != 1).num' | xargs -I {} swaymsg workspace number {}, move workspace to output $external_output
#!/usr/bin/env bash# Getting the new output nameexternal_output=$(swaymsg -t get_outputs | jq '.[].name | select(. != "eDP-1")')# Listing all workspaces but the first and move them to external outputswaymsg -rt get_workspaces | jq '.[]|select(.num != 1).num' | xargs -I {} swaymsg workspace number {}, move workspace to output $external_output

# Getting the external output name
external_output=$(swaymsg -t get_outputs | jq '.[].name | select(. != "eDP-1")')

# Get list of workspaces on eDP-1
internal_workspaces=$(swaymsg -t get_workspaces | jq '.[] | select(.output == "eDP-1") | .name')

# Get list of workspaces on external
external_workspaces=$(swaymsg -t get_workspaces | jq '.[] | select(.output == '"$external_output"') | .name')

# Get visible but unfocused workspace
visible=$(swaymsg -t get_workspaces | jq '.[] | select(.visible == true) | select(.focused == false) | .name')

# Get currently focused workspace
focused=$(swaymsg -t get_workspaces | jq '.[] | select(.focused == true) | .name')

# # Move eDP-1 workspaces to external
for workspace in $internal_workspaces; do
    swaymsg "workspace $workspace, move workspace to output $external_output"
done

# # Move external workspaces to eDP-1
for workspace in $external_workspaces; do
    swaymsg "workspace $workspace, move workspace to output eDP-1"
done

# Normally after swapping displays we want currently focused to be on other screen, 
# and visible workspace from other screen to be focused
swaymsg workspace $focused
swaymsg workspace $visible

