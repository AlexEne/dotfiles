-- Utility bindings

-- Menus
hl.bind("SUPER + SPACE",       hl.dsp.exec_cmd("pkill -x rofi || rofi -show drun"))
hl.bind("SUPER + ALT + SPACE", hl.dsp.exec_cmd("omarchy-menu"))
hl.bind("SUPER + CTRL + E",    hl.dsp.exec_cmd("qs ipc -c noctalia-shell call launcher emoji"))
hl.bind("SUPER + ESCAPE",      hl.dsp.exec_cmd("~/.config/hypr/scripts/power-menu.sh"))
hl.bind("XF86PowerOff",        hl.dsp.exec_cmd("~/.config/hypr/scripts/power-menu.sh"), { locked = true })
hl.bind("SUPER + K",           hl.dsp.exec_cmd("hyprctl binds"))
hl.bind("XF86Calculator",      hl.dsp.exec_cmd("gnome-calculator --mode=programming"))

-- Aesthetics
hl.bind("SUPER + SHIFT + SPACE",       hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-waybar.sh"))
hl.bind("SUPER + SHIFT + CTRL + SPACE", hl.dsp.exec_cmd("~/.config/hypr/scripts/theme-menu.sh"))
hl.bind("SUPER + BACKSPACE",           hl.dsp.exec_cmd([[hyprctl dispatch setprop "address:$(hyprctl activewindow -j | jq -r '.address')" opaque toggle]]))
hl.bind("SUPER + SHIFT + BACKSPACE",   hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-gaps.sh"))

-- Notifications
hl.bind("SUPER + COMMA",             hl.dsp.exec_cmd("makoctl dismiss"))
hl.bind("SUPER + SHIFT + COMMA",     hl.dsp.exec_cmd("makoctl dismiss --all"))
hl.bind("SUPER + CTRL + COMMA",      hl.dsp.exec_cmd([[makoctl mode -t do-not-disturb && makoctl mode | grep -q 'do-not-disturb' && notify-send "Silenced notifications" || notify-send "Enabled notifications"]]))
hl.bind("SUPER + ALT + COMMA",       hl.dsp.exec_cmd("makoctl invoke"))
hl.bind("SUPER + SHIFT + ALT + COMMA", hl.dsp.exec_cmd("makoctl restore"))

-- Toggle idling
hl.bind("SUPER + CTRL + I", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-idle.sh"))

-- Captures
-- (plain PRINT is overridden in bindings.lua -> omarchy-cmd-screenshot windows)
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]]))
hl.bind("ALT + PRINT",   hl.dsp.exec_cmd([[wf-recorder -a -f "$(xdg-user-dir VIDEOS)/recording-$(date +%Y%m%d-%H%M%S).mp4" & notify-send "Screen Recording" "Started"]]))
hl.bind("SUPER + PRINT", hl.dsp.exec_cmd("pkill hyprpicker || hyprpicker -a"))

-- File sharing
hl.bind("SUPER + CTRL + S", hl.dsp.exec_cmd([[rofi -dmenu -i -p "Share" -theme-str "window { width: 380px; } listview { lines: 6; }"]]))

-- Information
hl.bind("SUPER + CTRL + ALT + T", hl.dsp.exec_cmd([[notify-send " $(date +"%A %H:%M  —  %d %B W%V %Y")"]]))
hl.bind("SUPER + CTRL + ALT + B", hl.dsp.exec_cmd([[notify-send " Battery at $(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null || echo 'N/A')%"]]))

-- Control panels
hl.bind("SUPER + CTRL + A", hl.dsp.exec_cmd("uwsm-app -- ghostty -e wiremix"))
hl.bind("SUPER + CTRL + B", hl.dsp.exec_cmd("bash -c 'rfkill unblock bluetooth; uwsm-app -- ghostty -e bluetui'"))
hl.bind("SUPER + CTRL + W", hl.dsp.exec_cmd("bash -c 'rfkill unblock wifi; uwsm-app -- ghostty -e impala'"))
hl.bind("SUPER + CTRL + T", hl.dsp.exec_cmd("uwsm-app -- ghostty -e btop"))
