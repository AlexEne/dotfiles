#!/bin/bash
# Pick a screen pixel's color → clipboard + notification.
# Replaces hyprpicker (which is wlroots-only and doesn't work on niri).
POS=$(slurp -p) || exit 0
[ -z "$POS" ] && exit 0
HEX=$(grim -g "$POS 1x1" - | magick - -format "%[hex:p{0,0}]" info:)
[ -z "$HEX" ] && exit 1
wl-copy "$HEX"
notify-send "Color Picker" "$HEX copied to clipboard"
