#!/bin/bash
ADDR=$(hyprctl activewindow -j | jq -r '.address')
PINNED=$(hyprctl activewindow -j | jq '.pinned')
if [ "$PINNED" = "true" ]; then
  hyprctl dispatch pin address:$ADDR
  hyprctl dispatch togglefloating address:$ADDR
  notify-send "Window" "Returned to tiling"
else
  hyprctl dispatch togglefloating address:$ADDR
  hyprctl dispatch resizeactive exact 1300 900 address:$ADDR
  hyprctl dispatch centerwindow address:$ADDR
  hyprctl dispatch pin address:$ADDR
  hyprctl dispatch alterzorder top address:$ADDR
  notify-send "Window" "Popped out"
fi
