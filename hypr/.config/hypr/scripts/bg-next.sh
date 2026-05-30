#!/bin/bash
BG_DIR="$HOME/.config/omarchy/current/theme/backgrounds"
CURRENT_LINK="$HOME/.config/omarchy/current/background"

if [ ! -d "$BG_DIR" ]; then
  notify-send "Wallpaper" "No backgrounds directory found"
  exit 1
fi

ALL_BGS=$(find -L "$BG_DIR" -maxdepth 1 -type f | sort)
if [ -z "$ALL_BGS" ]; then
  notify-send "Wallpaper" "No background images found"
  exit 1
fi

CURRENT_BG=$(readlink "$CURRENT_LINK" 2>/dev/null)
NEXT_BG=$(echo "$ALL_BGS" | awk -v current="$CURRENT_BG" '
  BEGIN { found = 0; first = "" }
  {
    if (first == "") first = $0
    if (found) { print $0; exit }
    if ($0 == current) found = 1
  }
  END { if (!found || !found_then_printed) print first }
' | head -1)

if [ -z "$NEXT_BG" ]; then
  NEXT_BG=$(echo "$ALL_BGS" | head -1)
fi

ln -nsf "$NEXT_BG" "$CURRENT_LINK"
pkill -x swaybg 2>/dev/null
setsid uwsm-app -- swaybg -i "$CURRENT_LINK" -m fill >/dev/null 2>&1 &
notify-send "Wallpaper" "$(basename "$NEXT_BG")"
