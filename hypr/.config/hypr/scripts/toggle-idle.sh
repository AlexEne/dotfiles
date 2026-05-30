#!/bin/bash
if pgrep -x hypridle > /dev/null; then
  pkill -x hypridle
  notify-send "Idle" "Computer will not lock when idle"
else
  uwsm-app -- hypridle >/dev/null 2>&1 &
  notify-send "Idle" "Computer will lock when idle"
fi
