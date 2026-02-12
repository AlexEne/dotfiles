# Mouse Battery Monitor

Direct HID++ 2.0 battery monitor for Logitech wireless mice (e.g. PRO X 2 Superlight).
Bypasses solaar entirely — talks to the Lightspeed receiver via hidraw.

## Setup on a new system

Install the udev rule so your user can access the Logitech hidraw devices:

```sh
sudo cp 99-logitech-hidraw.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=hidraw
```

## Usage

```sh
# Simple JSON (for noctalia / scripts)
python3 mouse_battery.py

# Waybar JSON (icon + tooltip)
python3 mouse_battery.py --waybar
```
