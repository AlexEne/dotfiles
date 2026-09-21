-- User application bindings (overrides)

-- Terminal
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("uwsm-app -- ghostty"))
-- File manager
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd("uwsm-app -- nautilus --new-window"))
-- Browser
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("uwsm-app -- firefox"))
-- Browser (private)
hl.bind("SUPER + SHIFT + ALT + B", hl.dsp.exec_cmd("uwsm-app -- firefox --private-window"))
-- Toggle Microphone Mute
hl.bind("SUPER + SHIFT + Z", hl.dsp.exec_cmd("noctalia msg mic-mute"))
-- Editor
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("uwsm-app -- ghostty -e nvim"))
-- Activity (btop) — floating, launch-or-focus
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd("~/.config/hypr/scripts/launch-or-focus.sh btop btop"))
-- Signal
hl.bind("SUPER + SHIFT + G", hl.dsp.exec_cmd("uwsm-app -- signal-desktop"))
-- Center active window
hl.bind("SUPER + SHIFT + C", hl.dsp.window.center())

-- Wallpaper picker (Noctalia)
hl.bind("SUPER + CTRL + SPACE", hl.dsp.exec_cmd("noctalia msg panel-toggle wallpaper"))

-- Screenshot area with editing (always saved to ~/Pictures)
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh"))

-- PrintScreen: click a window to screenshot it (saved to ~/Pictures, edited in satty)
hl.bind("PRINT", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot-window.sh"))

-- Dictation
hl.bind("SUPER + D", hl.dsp.exec_cmd("wayscriber --active"))

-- Lock screen (Noctalia)
-- NOTE: this was broken in the old config (the unbind/bind lines were merged into
-- one malformed line in bindings.conf), so it never registered. Fixed here.
hl.bind("SUPER + CTRL + L", hl.dsp.exec_cmd("noctalia msg session lock"))

-- Layout toggle (dwindle <-> scrolling)
hl.bind("SUPER + L", hl.dsp.exec_cmd([[hyprctl getoption general:layout -j | jq -re '.str == "scrolling"' > /dev/null && hyprctl keyword general:layout dwindle || hyprctl keyword general:layout scrolling]]))
