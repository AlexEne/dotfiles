#!/bin/bash
# Region screenshot: always save to ~/Pictures, then open in satty for optional editing.
# File is written by grim BEFORE satty opens, so it's preserved even if you close satty
# or just copy to clipboard. Edits saved in satty overwrite the same file.

set -euo pipefail

OUTPUT_DIR="$HOME/Pictures"
mkdir -p "$OUTPUT_DIR"

FILE="$OUTPUT_DIR/screenshot-$(date +'%Y-%m-%d-%H-%M-%S').png"

# Let the user select a region. Exit silently if cancelled.
GEOMETRY="$(slurp)" || exit 0
[ -z "$GEOMETRY" ] && exit 0

# Capture and save immediately.
grim -g "$GEOMETRY" "$FILE"

# Open in satty for optional annotation. If the user edits and saves/copies,
# the same file is overwritten; if they just close it, the original remains.
satty \
  --filename "$FILE" \
  --output-filename "$FILE" \
  --early-exit \
  --copy-command 'wl-copy' \
  --actions-on-enter save-to-clipboard \
  --save-after-copy
