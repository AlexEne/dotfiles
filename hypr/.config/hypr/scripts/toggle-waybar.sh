#!/bin/bash
if pgrep -x waybar > /dev/null; then
  pkill -x waybar
  notify-send "Waybar" "Hidden"
else
  setsid uwsm-app -- waybar >/dev/null 2>&1 &
  notify-send "Waybar" "Shown"
fi
