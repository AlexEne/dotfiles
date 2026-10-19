#!/bin/bash
# Window screenshot (Print): pick a window with niri's interactive picker
# (crosshair cursor — click a window, Esc or click empty space to cancel),
# capture it with niri's built-in screenshot, then open it in satty for
# optional editing.
# niri writes the file AND copies it to the clipboard before satty opens,
# so the shot is preserved even if you close satty without saving.

set -euo pipefail

OUTPUT_DIR="$HOME/Pictures"
mkdir -p "$OUTPUT_DIR"

FILE="$OUTPUT_DIR/screenshot-$(date +'%Y-%m-%d-%H-%M-%S').png"

# Pick a window with the mouse. Exit silently if cancelled.
WIN="$(niri msg --json pick-window)" || exit 0
ID="$(jq -r '.id' <<<"$WIN")"
[ -n "$ID" ] && [ "$ID" != "null" ] || exit 0

# Capture straight to the target file (also lands on the clipboard).
niri msg action screenshot-window --id "$ID" --path "$FILE"

# The screenshot is written asynchronously; wait for it (max ~3s).
for _ in $(seq 1 60); do
    [ -s "$FILE" ] && break
    sleep 0.05
done
[ -s "$FILE" ] || exit 0

# Open in satty for optional annotation (same flags as screenshot.sh).
satty \
  --filename "$FILE" \
  --output-filename "$FILE" \
  --early-exit \
  --copy-command 'wl-copy' \
  --actions-on-enter save-to-clipboard \
  --save-after-copy
