#!/bin/bash
# Opens Qalculate! in its minimal one-line layout, even if it was expanded last time.
# Also drops the history timestamps it writes on exit, so the tracked config stays clean.

cfg=~/.config/qalculate/qalculate-gtk.cfg
tidy() { sed -i --follow-symlinks -e 's/^minimal_mode=.*/minimal_mode=1/' -e '/^history_time=/d' "$cfg"; }

swaymsg -q '[app_id="qalculate-gtk"] focus' 2>/dev/null && exit 0
tidy
qalculate-gtk
tidy
