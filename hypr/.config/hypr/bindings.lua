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
hl.bind("SUPER + SHIFT + Z", hl.dsp.exec_cmd("qs ipc -c noctalia-shell call volume muteInput"))
-- Editor
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("uwsm-app -- ghostty -e nvim"))
-- Activity (btop)
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd("uwsm-app -- ghostty -e btop"))
-- Signal
hl.bind("SUPER + SHIFT + G", hl.dsp.exec_cmd("uwsm-app -- signal-desktop"))
-- Center active window
hl.bind("SUPER + SHIFT + C", hl.dsp.window.center())

-- Wallpaper picker (Noctalia)
hl.bind("SUPER + CTRL + SPACE", hl.dsp.exec_cmd("qs ipc -c noctalia-shell call wallpaper toggle"))

-- Screenshot area with editing (always saved to ~/Pictures)
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh"))

-- PrintScreen: pick a window to screenshot (replaces the default grim+satty area shot)
hl.bind("PRINT", hl.dsp.exec_cmd("omarchy-cmd-screenshot windows"))

-- Dictation
hl.bind("SUPER + D", hl.dsp.exec_cmd("wayscriber --active"))

-- Lock screen (Noctalia)
-- NOTE: this was broken in the old config (the unbind/bind lines were merged into
-- one malformed line in bindings.conf), so it never registered. Fixed here.
hl.bind("SUPER + CTRL + L", hl.dsp.exec_cmd("qs ipc -c noctalia-shell call lockScreen lock"))

-- Layout toggle (dwindle <-> scrolling)
hl.bind("SUPER + L", hl.dsp.exec_cmd([[hyprctl getoption general:layout -j | jq -re '.str == "scrolling"' > /dev/null && hyprctl keyword general:layout dwindle || hyprctl keyword general:layout scrolling]]))
