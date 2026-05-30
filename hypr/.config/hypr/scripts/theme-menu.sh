#!/bin/bash
THEMES=$(ls -1 "$HOME/.config/omarchy/themes/" 2>/dev/null; ls -1 "$HOME/.local/share/omarchy/themes/" 2>/dev/null)
if [ -z "$THEMES" ]; then
  notify-send "Themes" "No themes found"
  exit 1
fi
CHOICE=$(echo "$THEMES" | sort -u | rofi -dmenu -i -p "Theme" -theme-str 'window { width: 380px; } listview { lines: 8; }')
[ -n "$CHOICE" ] && omarchy-theme-set "$CHOICE"
