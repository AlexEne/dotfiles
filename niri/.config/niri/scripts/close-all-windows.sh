#!/bin/bash
# Close all windows (niri port — was hyprctl clients/dispatch closewindow)
niri msg -j windows | jq -r '.[].id' | xargs -I{} niri msg action close-window --id {}
niri msg action focus-workspace 1
notify-send "Windows" "Closed all windows"
