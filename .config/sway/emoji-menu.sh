#!/bin/bash
# Emoji or symbol picker (rofi): Enter types and copies, Alt+c only copies, Shift+Enter marks several.
# Usage: emoji-menu.sh [emoji|symbols]

list=${1:-emoji}
data=~/.cache/emoji-menu/$list.tsv
counts=${XDG_STATE_HOME:-$HOME/.local/state}/emoji-menu/$list-counts

[ -s "$data" ] || ~/.config/sway/emoji-build.py >/dev/null || exit 1
mkdir -p "$(dirname "$counts")" && touch "$counts"

# Most used first, then Unicode order
picked=$(awk -F'\t' '
  FILENAME == ARGV[1] { n[$1] = $2; next }
  {
    name = $2; tags = $3
    gsub(/&/, "\\&amp;", name); gsub(/</, "\\&lt;", name)
    gsub(/&/, "\\&amp;", tags); gsub(/</, "\\&lt;", tags)
    printf "%d\t%d\t%s  %s  <span size=\"85%%\" foreground=\"#6272a4\">%s</span>\n", n[$1], FNR, $1, name, tags
  }' "$counts" "$data" |
  sort -t$'\t' -k1,1nr -k2,2n | cut -f3- |
  rofi -dmenu -i -markup-rows -multi-select -ballot-unselected-str '' -ballot-selected-str '✓ ' \
    -kb-custom-1 Alt+c -p "${list^}" -theme ~/.config/rofi/emoji.rasi)
rc=$?
[ -n "$picked" ] || exit 0

emoji=$(sed 's/  .*//' <<<"$picked")
text=$(tr -d '\n' <<<"$emoji")

wl-copy -- "$text"
# rofi exits 0 on Enter, 10 on Alt+c
if [ "$rc" -eq 0 ]; then
  sleep 0.1
  wtype -- "$text"
fi

{ sed 's/$/\t1/' <<<"$emoji"; cat "$counts"; } |
  awk -F'\t' -v OFS='\t' '{ n[$1] += $2 } END { for (e in n) print e, n[e] }' > "$counts.tmp" &&
  mv "$counts.tmp" "$counts"
