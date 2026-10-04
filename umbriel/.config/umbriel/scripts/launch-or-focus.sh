#!/bin/bash
# Launch a TUI app in a floating terminal window, or focus the existing one.
# Umbriel port of hypr/scripts/launch-or-focus.sh.
# Usage: launch-or-focus.sh <name> <command...>   e.g.: launch-or-focus.sh btop btop
# Window class becomes "tui.<name>"; float/center/size come from rules.toml.
#
# NOTE: JSON field names (id / app_id) follow the Umbriel IPC docs — verify
# against `umbriel windows --json` on first run and adjust if needed.

APP_ID="tui.$1"
shift

ID=$(umbriel windows --json | jq -r --arg c "$APP_ID" '.[] | select(.app_id == $c) | .id' | head -n1)

if [ -n "$ID" ]; then
  umbriel msg "window-focus:$ID" >/dev/null
else
  setsid uwsm-app -- xdg-terminal-exec --app-id="$APP_ID" -e "$@" >/dev/null 2>&1
fi
