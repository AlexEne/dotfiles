-- Hyprland Lua config (migrated from hyprlang .conf files)
-- Docs: https://wiki.hypr.land/Configuring/Start/
--
-- Once this file exists, Hyprland loads it INSTEAD of hyprland.conf.
-- The old .conf files are kept as backup but are ignored.
-- Rollback: delete/rename this file and restart Hyprland.

-- Environment variables
require("envs")

-- Display configuration
require("monitors")

-- Input devices
require("input")

-- Keybindings
require("media")
require("clipboard")
require("tiling")
require("utilities")

-- Look and feel
require("looknfeel")

-- Window rules
require("windows")

-- User application bindings (overrides)
require("bindings")

-- Autostart
require("autostart")

-- Active border color (final override, previously set in hyprland.conf)
local activeBorderColor = "rgba(c6d0f5ba)"

hl.config({
    general = {
        col = { active_border = activeBorderColor },
    },
    group = {
        col = { border_active = activeBorderColor },
    },
})

hl.window_rule({
    name     = "btop-min-size",
    match    = { class = "^(org\\.omarchy\\.btop)$" },
    min_size = { 1920, 1080 },
})
