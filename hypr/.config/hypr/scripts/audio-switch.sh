#!/bin/bash
SINKS=$(pactl list short sinks 2>/dev/null | awk '{print $2}')
if [ -z "$SINKS" ]; then
  notify-send "Audio" "No sinks found"
  exit 1
fi
CURRENT=$(pactl get-default-sink 2>/dev/null)
NEXT=""
FIRST=""
FOUND=0
for SINK in $SINKS; do
  [ -z "$FIRST" ] && FIRST="$SINK"
  if [ "$FOUND" = "1" ]; then
    NEXT="$SINK"
    break
  fi
  [ "$SINK" = "$CURRENT" ] && FOUND=1
done
[ -z "$NEXT" ] && NEXT="$FIRST"
pactl set-default-sink "$NEXT"
DESC=$(pactl list sinks 2>/dev/null | grep -A 20 "Name: $NEXT" | grep "Description:" | sed 's/.*Description: //')
notify-send "Audio Output" "$DESC"
