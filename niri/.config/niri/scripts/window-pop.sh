#!/bin/bash
# "Pop out" the focused window: float it at 1300x900 (niri port of window-pop.sh).
# Note: hyprland's `pin` (show on all workspaces) has no niri equivalent — dropped.
FLOATING=$(niri msg -j windows | jq -r '.[] | select(.is_focused) | .is_floating')
if [ "$FLOATING" = "true" ]; then
  niri msg action toggle-window-floating
  notify-send "Window" "Returned to tiling"
else
  niri msg action toggle-window-floating
  niri msg action set-window-width 1300
  niri msg action set-window-height 900
  notify-send "Window" "Popped out"
fi
