#!/bin/bash
# Close every window and return to workspace 1.
# Umbriel port of hypr/scripts/close-all-windows.sh.
# Field name note: see launch-or-focus.sh.

umbriel windows --json | jq -r '.[].id' | while read -r ID; do
  umbriel msg "window-close:$ID" >/dev/null
done
umbriel msg "workspace-switch:1" >/dev/null
notify-send "Windows" "Closed all windows"
