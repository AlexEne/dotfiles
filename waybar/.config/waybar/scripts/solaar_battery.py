
#!/usr/bin/env python3

import subprocess
import re
import json

# Icons for different battery levels
BATTERY_ICONS = [
    "󰁺",  # 0-10%
    "󰁻",  # 11-20%
    "󰁼",  # 21-30%
    "󰁽",  # 31-40%
    "󰁾",  # 41-50%
    "󰁿",  # 51-60%
    "󰂀",  # 61-70%
    "󰂁",  # 71-80%
    "󰂂",  # 81-90%
    "󰂅"   # 91-100%
]

CHARGING_ICON = "󰂊"  # Icon for charging

def get_battery_info():
    try:
        # Run `solaar show` and capture the output
        result = subprocess.run(["solaar", "show"], stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, text=True)
        output = result.stdout

        # Extract the battery percentage using regex
        percentage_match = re.search(r"Battery:\s+(\d+)%", output)
        percentage = int(percentage_match.group(1)) if percentage_match else None

        # Check if the device is charging
        charging = "BatteryStatus.CHARGING" in output

        # Extract the mouse name
        name_match = re.search(r"Name:\s+(.+)", output)
        name = name_match.group(1).strip() if name_match else "Unknown Device"

        return percentage, charging, name
    except Exception as e:
        return None, False, "Unknown Device"

def get_icon(percentage, charging):
    if charging:
        return CHARGING_ICON
    # Map the percentage to the appropriate icon
    index = min(len(BATTERY_ICONS) - 1, percentage // 10)
    return BATTERY_ICONS[index]

def main():
    # Get the battery percentage, charging status, and mouse name
    percentage, charging, name = get_battery_info()
    if percentage is None:
        print(json.dumps({"text": "󰁺", "tooltip": "Battery status unavailable", "class": "error"}))
        return

    # Get the appropriate icon
    icon = get_icon(percentage, charging)

    # Prepare the JSON output
    output = {
        "text": icon,  # Only the icon is displayed
        "tooltip": f"{name}: {percentage}%{icon}",  # Tooltip includes the mouse name and percentage
        "class": "charging" if charging else "discharging"
    }

    # Print the JSON output
    print(json.dumps(output))

if __name__ == "__main__":
    main()
