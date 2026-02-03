# Mouse Battery Widget for Noctalia

A Noctalia bar widget that displays the battery level of your Logitech mouse using Solaar.

## Features

- Shows battery icon that changes based on charge level
- Color-coded battery status:
  - Red: ≤10% (critical)
  - Orange: ≤20% (warning)
  - Gray: Normal
  - Blue: Charging
- Tooltip displays mouse name, percentage, and charging status
- Click to manually refresh battery status
- Auto-refreshes every 15 minutes (configurable)

## Requirements

- Solaar must be installed and running
- Python 3

## Installation

The plugin is already installed in `~/.config/noctalia/plugins/mouse-battery/`

To enable it:
1. Restart noctalia shell (or reload: `killall qs && qs -c noctalia-shell &`)
2. Open Noctalia Settings
3. Go to Bar → Widgets Positioning
4. Click "Add" in your desired section (Left/Center/Right)
5. Select "Mouse Battery" from the list
6. Drag to reorder as needed

## Configuration

The widget can be configured in the plugin settings:

- `updateInterval`: How often to refresh battery status in seconds (default: 900 = 15 minutes)

## Troubleshooting

If the widget shows an error icon:
- Make sure Solaar is installed: `pacman -Q solaar`
- Check if Solaar is running: `ps aux | grep solaar`
- Test the script manually: `python3 ~/.config/noctalia/plugins/mouse-battery/solaar_battery.py`
- Check if your mouse is connected and detected by Solaar: `solaar show`
