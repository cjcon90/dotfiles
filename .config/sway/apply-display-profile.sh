#!/usr/bin/env bash
#
# Detect which desk we're at (by monitor serial) and apply that output layout.
# Run automatically by exec_always in ~/.config/sway/config, and on demand.

set -u

connected() {
    swaymsg -t get_outputs | jq -r --arg s "$1" '.[] | select(.serial == $s) | .name'
}

externals() {
    swaymsg -t get_outputs | jq -r '.[] | select(.name != "eDP-1") | .name'
}

dell=$(connected HXSZR83)     # Dell P3222QE  32" 4K
lenovo=$(connected VNA56606)  # Lenovo T32p-20 32" 4K (link-limited to 4K30)

if [ -n "$dell" ] && [ -n "$lenovo" ]; then
    ### Hot-desk: Dell on the left, Lenovo on the right, laptop centred below.
    # Lenovo runs its native 4K mode with a 1.25 fractional scale, giving a
    # 3072x1728 logical size -- text ~25% larger than the Dell. Native mode is
    # capped at 30Hz here: its EDID advertises no 4K60 on this link.
    # linear filtering keeps non-scale-aware (XWayland) clients from looking
    # blocky under the fractional scale.
    # Both externals are 31.5" 4K, so they share scale 1.25 to render the same
    # physical text size -- 3072x1728 logical each, sitting side by side.
    swaymsg "output $dell   mode 3840x2160@59.997Hz position 0 0 scale 1.25 scale_filter linear"
    swaymsg "output $lenovo mode 3840x2160@30Hz position 3072 0 scale 1.25 scale_filter linear"
    swaymsg "output eDP-1   position 2112 1728 scale 1"

elif [ -n "$lenovo" ]; then
    ### Hot-desk, Lenovo only: monitor stacked directly above the laptop.
    # Native 4K at scale 1.25 -> 3072x1728 logical. Capped at 30Hz: its EDID
    # advertises no 4K60 on this link. linear filtering keeps non-scale-aware
    # (XWayland) clients from looking blocky under the fractional scale.
    # Laptop is horizontally centred under it: (3072 - 1920) / 2 = 576.
    swaymsg "output $lenovo mode 3840x2160@30Hz position 0 0 scale 1.25 scale_filter linear"
    swaymsg "output eDP-1   position 576 1728 scale 1"

elif [ "$(externals | wc -l)" -eq 1 ]; then
    ### Home desk (or any single external): external top-left, laptop
    # horizontally centred directly below it, sized from the external's mode.
    ext=$(externals)
    swaymsg "output $ext   position 0 0 scale 1"
    read -r ext_w ext_h < <(swaymsg -t get_outputs | jq -r --arg n "$ext" \
        '.[] | select(.name == $n) | "\(.current_mode.width) \(.current_mode.height)"')
    lap_w=$(swaymsg -t get_outputs | jq -r '.[] | select(.name == "eDP-1") | .current_mode.width')
    swaymsg "output eDP-1 position $(( (ext_w - lap_w) / 2 )) $ext_h scale 1"

else
    ### Laptop only.
    swaymsg "output eDP-1 position 0 0 scale 1"
fi
