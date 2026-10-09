#!/bin/bash
# DO A BARREL ROLL: smoothly spin a snapshot of every screen 360° while the keyboard goes full
# rainbow spiral. Real windows and outputs are never touched, so nothing needs fixing up after.

# Draws the banner: a plane flies in from the right towing the message, then circles in place
# while the spin renders. Runs inside the floating alacritty window started below.
if [ "$1" = banner ]; then
    export LC_ALL=C.UTF-8
    sleep 0.2; tput civis
    cols=$(tput cols) rows=$(tput lines)
    pink=$'\e[1;38;2;255;121;198m' purple=$'\e[1;38;2;189;147;249m' grey=$'\e[38;2;98;114;164m'
    yellow=$'\e[1;38;2;241;250;140m'
    bar=$(printf '━%.0s' $(seq $((cols - 2))))
    printf '%s┏%s┓' "$pink" "$bar"
    for r in $(seq 2 $((rows - 1))); do printf '\e[%d;1H┃\e[%d;%dH┃' $r $r $cols; done
    printf '\e[%d;1H┗%s┛' $rows "$bar"

    text="  DO A BARREL ROLL!  "
    line=$(printf '━%.0s' $(seq ${#text}))
    gap="     "
    plane=('         __           ' '   _____/  \_____  /| ' '<______________==_| ' '         \__\         ')
    props=('|' '/' '-' '\')
    ropes=('~-~-~' '-~-~-')
    width=$((22 + 5 + ${#text} + 2)) top=$(((rows - 4) / 2 + 1))

    # Print $4 in colour $3 at row $1, column $2 (1-based), clipped to the inside of the frame
    shopt -s extglob
    put() {
        local room=$((cols - $2)) plain=${4//$'\e'\[*([0-9;])m/}
        ((room <= 0)) && return
        ((${#plain} > room)) && set -- $1 $2 "$3" "${plain:0:room}"
        printf '\e[%d;%dH%s%s' $1 $2 "$3" "$4"
    }
    x=$((cols - 1)) stop=$(((cols - width) / 2 + 1)) frame=0
    while :; do
        out=$(
            put $top $x "$purple" "${plane[0]}  "
            put $((top + 1)) $x "$purple" "${plane[1]}$gap$pink┏${line}┓  "
            put $((top + 2)) $x "$purple" "${props[frame % 4]} ${plane[2]}$grey${ropes[frame / 2 % 2]}$pink┃$yellow$text$pink┃  "
            put $((top + 3)) $x "$purple" "${plane[3]}$gap$pink┗${line}┛  "
        )
        printf '%s' "$out"
        ((frame++))
        if ((x > stop)); then x=$((x - 2 < stop ? stop : x - 2)); sleep 0.035; else sleep 0.06; fi
        ((frame > 400)) && break
    done
    exit
fi

exec 9>/tmp/barrel-roll.lock
flock -n 9 || exit

state=/var/lib/kbd-rainbow/state.json
work=$(mktemp -d)
cp "$state" "$work/state.json"
focused=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused).name')
outputs=$(swaymsg -t get_outputs | jq -r '.[] | select(.active).name')

# Big centred banner (floated by the app_id="barrel-roll" rule in sway config)
alacritty --class barrel-roll -o font.size=28 -o 'colors.primary.background="#282A36"' -e "$0" banner &
banner=$!
/usr/local/bin/kbd-rainbow --mode spiral --brightness 1 --speed 1

# Snapshot each screen (banner included) and pre-render its spin while the banner shows
sleep 0.4
renders=()
for o in $outputs; do
    (grim -o "$o" -t ppm "$work/$o.ppm" &&
        ffmpeg -loglevel error -i "$work/$o.ppm" -vf scale=960:-2 "$work/$o-small.ppm" &&
        ffmpeg -loglevel error -loop 1 -framerate 40 -t 1.6 -i "$work/$o-small.ppm" \
            -vf "rotate=2*PI*t/1.6:c=black:bilinear=0,tpad=start_duration=0.5:start_mode=clone,format=yuv420p" \
            -c:v mjpeg -q:v 4 "$work/$o.avi") &
    renders+=($!)
done
wait "${renders[@]}"

# Play each spin fullscreen on its own screen (made fullscreen by the title="^barrel-spin" rule).
# Each video holds still for 0.5s; later players skip ahead by how late they launched, so all spin together.
# Peppy Hare, as near as eSpeak gets
espeak-ng -v en-us+grandpa -p 75 -s 190 "Do a barrel roll!" &
players=()
start=$EPOCHREALTIME
for o in $outputs; do
    swaymsg -q focus output "$o"
    late=$(awk "BEGIN { print $EPOCHREALTIME - $start }")
    ffplay -loglevel error -an -autoexit -ss "$late" -window_title "barrel-spin-$o" "$work/$o.avi" &
    players+=($!)
    for _ in $(seq 20); do
        swaymsg -t get_tree | grep -q "\"barrel-spin-$o\"" && break
        sleep 0.05
    done
done
swaymsg -q focus output "$focused"
wait "${players[@]}"

kill $banner
sleep 0.5
install -m 664 "$work/state.json" "$state.barrel-roll"
mv -f "$state.barrel-roll" "$state"
rm -rf "$work"
