#!/bin/bash
# Pop the active window out: float, size, center, pin — and back.
# Umbriel port of hypr/scripts/window-pop.sh.
#
# Differences from the Hyprland original:
# - no zorder raise action (pinning keeps it above regular windows anyway)
# - floating sizes are fractions of the usable area, not pixels
#   (1300x900 on 3840x1600 ≈ 0.34 x 0.56)
# Field name note: .focused / .pinned follow the IPC docs — verify against
# `umbriel windows --json` on first run.

PINNED=$(umbriel windows --json | jq -r '.[] | select(.focused) | .pinned')

if [ "$PINNED" = "true" ]; then
  umbriel msg window-toggle-pinned >/dev/null
  umbriel msg window-toggle-floating >/dev/null
  notify-send "Window" "Returned to tiling"
else
  umbriel msg window-toggle-floating >/dev/null
  umbriel msg window-set-primary-extent:0.34 >/dev/null
  umbriel msg window-set-secondary-extent:0.56 >/dev/null
  umbriel msg window-center >/dev/null
  umbriel msg window-toggle-pinned >/dev/null
  notify-send "Window" "Popped out"
fi
