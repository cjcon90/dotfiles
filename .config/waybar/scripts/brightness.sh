#!/usr/bin/env bash
# Usage: brightness.sh get|up|down [output]

set -u

action=${1:-get}
out=${2:-${WAYBAR_OUTPUT_NAME:-}}
# Waybar doesn't set this for on-scroll; focus_follows_mouse makes the hovered bar's output focused.
[ -n "$out" ] || out=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
LAPTOP_STEP=1
DDC_STEP=2
CACHE_TTL=55
cache_dir=$XDG_RUNTIME_DIR/ddc-brightness
cache=$cache_dir/$out

refresh_bars() { pkill -RTMIN+8 -x waybar; }

emit() { printf '{"text": "%s", "percentage": %s, "tooltip": "%s: %s%%"}\n' "$1" "$1" "$out" "$1"; }

if [[ $out == eDP-* ]]; then
    case $action in
        up)   swayosd-client --monitor "$out" --brightness "+$LAPTOP_STEP"; refresh_bars ;;
        down) swayosd-client --monitor "$out" --brightness "-$LAPTOP_STEP"; refresh_bars ;;
        *)    emit "$(brightnessctl -m | cut -d, -f4 | tr -d %)" ;;
    esac
    exit 0
fi

mkdir -p "$cache_dir"

# Dock (MST) outputs may lack a sysfs ddc link, so fall back to slow ddcutil detect.
find_bus() {
    local ddc
    ddc=$(ls -d /sys/class/drm/card*-"$out"/ddc 2>/dev/null | head -1)
    if [ -n "$ddc" ]; then
        basename "$(readlink -f "$ddc")" | sed 's/^i2c-//'
    elif [ -s "$cache.bus" ]; then
        cat "$cache.bus"
    else
        ddcutil detect 2>/dev/null | awk -v want="-$out" '
            /I2C bus:/       { bus = $NF; sub(".*i2c-", "", bus) }
            /DRM[_ ]connector:/ { c = $NF; if (substr(c, length(c) - length(want) + 1) == want) print bus }
        ' | head -1 | tee "$cache.bus"
    fi
}
bus=$(find_bus)
[ -n "$bus" ] || { [ "$action" = get ] && echo '{"text": ""}'; exit 0; }

ddc() { ddcutil --bus "$bus" --skip-ddc-checks "$@" 2>/dev/null; }

read_ddc() { ddc getvcp 10 --brief | awk '{print $4}'; }

current() {
    if [ -n "$(find "$cache" -newermt "-$CACHE_TTL seconds" 2>/dev/null)" ]; then
        cat "$cache"
    else
        local val
        val=$(read_ddc)
        [ -n "$val" ] && echo "$val" > "$cache"
        echo "$val"
    fi
}

case $action in
    up|down)
        exec 8>"$cache.step"
        flock 8
        cur=$(current)
        [ -n "$cur" ] || exit 0
        [ "$action" = up ] && new=$((cur + DDC_STEP)) || new=$((cur - DDC_STEP))
        new=$(( new > 100 ? 100 : new < 0 ? 0 : new ))
        echo "$new" > "$cache"
        flock -u 8
        refresh_bars
        swayosd-client --monitor "$out" --custom-icon display-brightness-symbolic \
            --custom-progress "$(awk -v n="$new" 'BEGIN { printf "%.2f", n / 100 }')" &

        # Single writer applies only the latest level, so fast scrolls don't queue up.
        exec 9>"$cache.write"
        while flock -n 9; do
            applied=
            while want=$(cat "$cache"); [ "$want" != "$applied" ]; do
                ddc --noverify setvcp 10 "$want"
                applied=$want
            done
            flock -u 9
            [ "$(cat "$cache")" = "$applied" ] && break
        done
        ;;
    *)
        val=$(current)
        [ -n "$val" ] && emit "$val" || echo '{"text": ""}'
        ;;
esac
