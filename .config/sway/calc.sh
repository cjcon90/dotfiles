#!/bin/bash
# Opens Qalculate! in its minimal one-line layout, even if it was expanded last time.

cfg=~/.config/qalculate/qalculate-gtk.cfg
minimal() { sed -i --follow-symlinks 's/^minimal_mode=.*/minimal_mode=1/' "$cfg"; }

swaymsg -q '[app_id="qalculate-gtk"] focus' 2>/dev/null && exit 0
minimal
qalculate-gtk
minimal
