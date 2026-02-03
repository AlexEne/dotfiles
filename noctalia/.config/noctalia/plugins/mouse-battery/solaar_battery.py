#!/usr/bin/env python3

import subprocess
import re
import json
import sys

def get_battery_info():
    """Get battery info from Solaar"""
    try:
        # Run `solaar show` and capture the output
        result = subprocess.run(
            ["solaar", "show"], 
            stdout=subprocess.PIPE, 
            stderr=subprocess.DEVNULL, 
            text=True,
            timeout=5
        )
        output = result.stdout

        # Extract the battery percentage using regex
        percentage_match = re.search(r"Battery:\s+(\d+)%", output)
        percentage = int(percentage_match.group(1)) if percentage_match else None

        # Check if the device is charging
        charging = "BatteryStatus.CHARGING" in output

        # Extract the mouse name
        name_match = re.search(r"Name:\s+(.+)", output)
        name = name_match.group(1).strip() if name_match else "Unknown Device"

        if percentage is None:
            return {"error": "No battery found"}

        return {
            "percentage": percentage,
            "charging": charging,
            "name": name
        }
    except subprocess.TimeoutExpired:
        return {"error": "Solaar timeout"}
    except FileNotFoundError:
        return {"error": "Solaar not found"}
    except Exception as e:
        return {"error": str(e)}

if __name__ == "__main__":
    battery_info = get_battery_info()
    print(json.dumps(battery_info))
    sys.exit(0 if "error" not in battery_info else 1)
