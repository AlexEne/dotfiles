#!/bin/bash
# Window screenshot: click a window to capture it, save to ~/Pictures, open in satty.
# Umbriel port of hypr/scripts/screenshot-window.sh.
#
# NOTE: the geometry field path (.geometry.x/.y/.width/.height) follows the
# Umbriel IPC docs ("window entries include ... geometry") — verify against
# `umbriel windows --json` on first run and adjust if the shape differs.
# Unlike the Hyprland original this lists all windows (no visible-workspace
# filter); slurp -r still snaps the selection to the window under the cursor.

set -euo pipefail

OUTPUT_DIR="$HOME/Pictures"
mkdir -p "$OUTPUT_DIR"

FILE="$OUTPUT_DIR/screenshot-$(date +'%Y-%m-%d-%H-%M-%S').png"

GEOMETRY="$(umbriel windows --json \
  | jq -r '.[] | "\(.geometry.x),\(.geometry.y) \(.geometry.width)x\(.geometry.height)"' \
  | slurp -r)" || exit 0
[ -z "$GEOMETRY" ] && exit 0

grim -g "$GEOMETRY" "$FILE"

satty \
  --filename "$FILE" \
  --output-filename "$FILE" \
  --early-exit \
  --copy-command 'wl-copy' \
  --actions-on-enter save-to-clipboard \
  --save-after-copy
