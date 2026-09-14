#!/bin/bash
# Launch a TUI app in a floating terminal window, or focus the existing one.
# Usage: launch-or-focus.sh <name> <command...>   e.g.: launch-or-focus.sh btop btop
# Window class becomes "tui.<name>" (dotted app-id is required — ghostty rejects
# class values without a dot). Floating/centering comes from the window rules
# in ~/.config/hypr/windows.lua matching the class.

APP_ID="tui.$1"
shift

ADDR=$(hyprctl clients -j | jq -r --arg c "$APP_ID" '.[] | select(.class == $c) | .address' | head -n1)

if [ -n "$ADDR" ]; then
  hyprctl dispatch focuswindow "address:$ADDR" >/dev/null
else
  setsid uwsm-app -- xdg-terminal-exec --app-id="$APP_ID" -e "$@" >/dev/null 2>&1
fi
