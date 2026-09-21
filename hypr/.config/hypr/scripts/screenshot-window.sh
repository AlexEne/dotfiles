#!/bin/bash
# Window screenshot: click a window to capture it, save to ~/Pictures, open in satty.
# File is written by grim BEFORE satty opens, so it's preserved even if you close satty
# or just copy to clipboard. Edits saved in satty overwrite the same file.

set -euo pipefail

OUTPUT_DIR="$HOME/Pictures"
mkdir -p "$OUTPUT_DIR"

FILE="$OUTPUT_DIR/screenshot-$(date +'%Y-%m-%d-%H-%M-%S').png"

# List geometry of windows on visible workspaces, let user click one (slurp -r
# snaps the selection to the window under the cursor). Exit silently if cancelled.
GEOMETRY="$(hyprctl clients -j \
  | jq -r --argjson ws "$(hyprctl monitors -j | jq '[.[].activeWorkspace.id]')" \
    '.[] | select(.mapped and (.workspace.id as $id | $ws | index($id))) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' \
  | slurp -r)" || exit 0
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
