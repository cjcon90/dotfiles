#!/usr/bin/env bash

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

# Move eDP-1 workspaces to external
for workspace in $internal_workspaces; do
    swaymsg "workspace $workspace, move workspace to output $external_output"
done

# Move external workspaces to eDP-1
for workspace in $external_workspaces; do
    swaymsg "workspace $workspace, move workspace to output eDP-1"
done

# Restore focus: focused on other screen, visible from other screen becomes focused
swaymsg workspace $focused
swaymsg workspace $visible
