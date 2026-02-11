#!/usr/bin/env python3
"""
Direct HID++ 2.0 battery monitor for Logitech wireless mice.

Communicates directly with the Logitech Lightspeed receiver via hidraw,
bypassing solaar entirely. Supports Unified Battery (feature 0x1004).

Usage:
    mouse_battery.py            # Simple JSON: {"percentage": N, "charging": bool, "name": "..."}
    mouse_battery.py --waybar   # Waybar JSON: {"text": "icon", "tooltip": "...", "class": "..."}
"""

import glob
import json
import os
import sys
import time

# Logitech vendor ID and known Lightspeed receiver product IDs
LOGITECH_VENDOR = "046D"
LIGHTSPEED_PRODUCTS = {"C547", "C548", "C54D", "C541", "C545"}

# HID++ constants
HIDPP_SHORT = 0x10  # 7-byte report
HIDPP_LONG = 0x11   # 20-byte report
DEVICE_INDEX = 0x01  # First paired device
SW_ID = 0x0A         # Software identifier nibble

# HID++ 2.0 feature IDs
FEATURE_ROOT = 0x0000
FEATURE_DEVICE_NAME = 0x0005
FEATURE_UNIFIED_BATTERY = 0x1004

# Battery status codes (Unified Battery 0x1004)
BATTERY_STATUS = {
    0: "discharging",
    1: "charging",
    2: "charging",       # slow charging
    3: "charging",       # charge complete (still "charging" class for simplicity)
    4: "charging",       # recharging below optimal speed
    5: "error",          # invalid battery
    6: "error",          # thermal error
}

# Nerd Font battery icons for waybar
BATTERY_ICONS = [
    "\U000f007a",  # 󰁺 0-10%
    "\U000f007b",  # 󰁻 11-20%
    "\U000f007c",  # 󰁼 21-30%
    "\U000f007d",  # 󰁽 31-40%
    "\U000f007e",  # 󰁾 41-50%
    "\U000f007f",  # 󰁿 51-60%
    "\U000f0080",  # 󰂀 61-70%
    "\U000f0081",  # 󰂁 71-80%
    "\U000f0082",  # 󰂂 81-90%
    "\U000f0085",  # 󰂅 91-100%
]
CHARGING_ICON = "\U000f008a"  # 󰂊


def find_hidraw_device():
    """Find the HID++ hidraw device for the Logitech Lightspeed receiver.

    Scans /sys/class/hidraw/ and picks the highest-numbered interface
    for the matching receiver (interface 2 is used for HID++).
    """
    candidates = []

    for sysfs in sorted(glob.glob("/sys/class/hidraw/hidraw*")):
        uevent_path = os.path.join(sysfs, "device", "uevent")
        try:
            with open(uevent_path) as f:
                uevent = f.read()
        except OSError:
            continue

        props = {}
        for line in uevent.strip().split("\n"):
            if "=" in line:
                k, v = line.split("=", 1)
                props[k] = v

        hid_id = props.get("HID_ID", "")
        parts = hid_id.split(":")
        if len(parts) >= 3:
            vendor = parts[1].upper().lstrip("0") or "0"
            product = parts[2].upper().lstrip("0") or "0"
            # Pad back to 4 chars for comparison
            vendor = vendor.zfill(4)
            product = product.zfill(4)

            if vendor == LOGITECH_VENDOR and product in LIGHTSPEED_PRODUCTS:
                name = os.path.basename(sysfs)  # e.g. "hidraw9"
                idx = int(name.replace("hidraw", ""))
                candidates.append((idx, f"/dev/{name}"))

    if not candidates:
        return None

    # Pick the highest index = interface 2 (HID++ interface)
    candidates.sort(key=lambda x: x[0])
    return candidates[-1][1]


def hid_write(fd, data):
    """Write to hidraw with retry on EPROTO (mouse asleep)."""
    for attempt in range(6):
        try:
            os.write(fd, data)
            return True
        except OSError as e:
            if e.errno in (71, 32):  # EPROTO, EPIPE
                time.sleep(0.15 * (attempt + 1))
            else:
                raise
    return False


def hid_read_response(fd, device, feature_idx, timeout=2.0):
    """Read HID++ response matching device and feature index."""
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        try:
            resp = os.read(fd, 32)
            if len(resp) >= 4 and resp[1] == device and resp[2] == feature_idx:
                return resp
        except BlockingIOError:
            time.sleep(0.03)
        except OSError:
            time.sleep(0.05)
    return None


def hidpp_request(fd, device, feature_idx, function, *args):
    """Send a HID++ 2.0 long request and return the response."""
    payload = list(args) + [0] * (16 - len(args))
    msg = bytes([HIDPP_LONG, device, feature_idx, (function << 4) | SW_ID] + payload)

    for attempt in range(4):
        if not hid_write(fd, msg):
            continue
        resp = hid_read_response(fd, device, feature_idx, timeout=1.0)
        if resp is not None:
            return resp
        # No response — mouse may have gone back to sleep, retry
        time.sleep(1)

    return None


def wake_mouse(fd):
    """Send a ping to wake the mouse from sleep."""
    msg = bytes([HIDPP_SHORT, DEVICE_INDEX, 0x00, 0x10, 0x00, 0x00, 0xAA])
    for _ in range(5):
        try:
            os.write(fd, msg)
            time.sleep(0.08)
            try:
                resp = os.read(fd, 32)
                if resp and len(resp) >= 4 and resp[1] == DEVICE_INDEX:
                    return True
            except BlockingIOError:
                pass
        except OSError:
            time.sleep(0.2)
    return False


def drain(fd):
    """Drain any pending events from the device."""
    while True:
        try:
            os.read(fd, 32)
        except (BlockingIOError, OSError):
            break


def get_feature_index(fd, feature_id):
    """Look up the feature index for a given HID++ 2.0 feature ID."""
    hi = (feature_id >> 8) & 0xFF
    lo = feature_id & 0xFF
    resp = hidpp_request(fd, DEVICE_INDEX, 0x00, 0, hi, lo)
    if resp and resp[4] != 0:
        return resp[4]
    return None


def get_battery(fd, battery_idx):
    """Query Unified Battery status. Returns (percentage, charging, status_name)."""
    resp = hidpp_request(fd, DEVICE_INDEX, battery_idx, 1)
    if resp is None:
        return None, None, None

    soc = resp[4]
    status_code = resp[6]
    charging = status_code in (1, 2, 3, 4)
    status_name = BATTERY_STATUS.get(status_code, "unknown")

    return soc, charging, status_name


def get_device_name(fd, name_idx):
    """Query the device name via HID++ 2.0 DeviceName feature."""
    # Function 0 = getCount (returns name length)
    resp = hidpp_request(fd, DEVICE_INDEX, name_idx, 0)
    if resp is None:
        return None

    name_len = resp[4]
    name = b""
    offset = 0
    while offset < name_len:
        resp = hidpp_request(fd, DEVICE_INDEX, name_idx, 1, offset)
        if resp is None:
            break
        chunk_len = min(16, name_len - offset)
        name += bytes(b for b in resp[4:4 + chunk_len] if b != 0)
        offset += 16

    return name.decode("utf-8", errors="replace") if name else None


def get_battery_icon(percentage, charging):
    """Return the appropriate Nerd Font battery icon."""
    if charging:
        return CHARGING_ICON
    index = min(len(BATTERY_ICONS) - 1, percentage // 10)
    return BATTERY_ICONS[index]


def main():
    waybar_mode = "--waybar" in sys.argv

    # Find device
    devpath = find_hidraw_device()
    if devpath is None:
        result = {"error": "No Logitech Lightspeed receiver found"}
        if waybar_mode:
            result = {"text": "", "tooltip": result["error"], "class": "error"}
        print(json.dumps(result))
        sys.exit(1)

    try:
        fd = os.open(devpath, os.O_RDWR | os.O_NONBLOCK)
    except PermissionError:
        result = {"error": f"Permission denied: {devpath}"}
        if waybar_mode:
            result = {"text": "", "tooltip": result["error"], "class": "error"}
        print(json.dumps(result))
        sys.exit(1)

    try:
        drain(fd)
        wake_mouse(fd)

        # Get battery feature index
        battery_idx = get_feature_index(fd, FEATURE_UNIFIED_BATTERY)
        if battery_idx is None:
            result = {"error": "Battery feature not found"}
            if waybar_mode:
                result = {"text": "", "tooltip": result["error"], "class": "error"}
            print(json.dumps(result))
            sys.exit(1)

        # Get battery status
        percentage, charging, status_name = get_battery(fd, battery_idx)
        if percentage is None:
            result = {"error": "Could not read battery status"}
            if waybar_mode:
                result = {"text": "", "tooltip": result["error"], "class": "error"}
            print(json.dumps(result))
            sys.exit(1)

        # Get device name
        name_idx = get_feature_index(fd, FEATURE_DEVICE_NAME)
        name = get_device_name(fd, name_idx) if name_idx else None
        name = name or "Logitech Mouse"

        # Output
        if waybar_mode:
            icon = get_battery_icon(percentage, charging)
            result = {
                "text": icon,
                "tooltip": f"{name}: {percentage}%{icon}",
                "class": "charging" if charging else "discharging",
            }
        else:
            result = {
                "percentage": percentage,
                "charging": charging,
                "name": name,
            }

        print(json.dumps(result))

    except Exception as e:
        result = {"error": str(e)}
        if waybar_mode:
            result = {"text": "", "tooltip": str(e), "class": "error"}
        print(json.dumps(result))
        sys.exit(1)
    finally:
        os.close(fd)


if __name__ == "__main__":
    main()
