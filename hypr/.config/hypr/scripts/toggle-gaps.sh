#!/bin/bash
WS_ID=$(hyprctl activeworkspace -j | jq '.id')
RULE_EXISTS=$(hyprctl workspacerules -j | jq "any(.[]; .workspaceString == \"$WS_ID\" and .gapsOut[0] == 0)")
if [ "$RULE_EXISTS" = "true" ]; then
  hyprctl keyword "workspace $WS_ID, gapsout:10, gapsin:5, bordersize:2"
  notify-send "Gaps" "Enabled"
else
  hyprctl keyword "workspace $WS_ID, gapsout:0, gapsin:0, bordersize:0"
  notify-send "Gaps" "Disabled"
fi
