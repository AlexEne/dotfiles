-- Window and layer rules
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Ignore maximize requests from all apps
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Fully opaque windows by default
hl.window_rule({
    name    = "default-opaque",
    match   = { class = ".*" },
    opacity = "1.0 1.0",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Terminal tagging
hl.window_rule({
    name  = "tag-terminals",
    match = { class = "(Alacritty|kitty|com.mitchellh.ghostty)" },
    tag   = "+terminal",
})

-- Browser types
hl.window_rule({
    name  = "tag-chromium-browsers",
    match = { class = "((google-)?[cC]hrom(e|ium)|[bB]rave-browser|[mM]icrosoft-edge|Vivaldi-stable|helium)" },
    tag   = "+chromium-based-browser",
})
hl.window_rule({
    name  = "tag-firefox-browsers",
    match = { class = "([fF]irefox|zen|librewolf)" },
    tag   = "+firefox-based-browser",
})

hl.window_rule({
    name  = "tile-chromium-browsers",
    match = { tag = "chromium-based-browser" },
    tile  = true,
})
hl.window_rule({
    name    = "opaque-chromium-browsers",
    match   = { tag = "chromium-based-browser" },
    opacity = "1.0 1.0",
})
hl.window_rule({
    name    = "opaque-firefox-browsers",
    match   = { tag = "firefox-based-browser" },
    opacity = "1.0 1.0",
})
hl.window_rule({
    name    = "opaque-video-pages",
    match   = { initial_title = "((?i)(?:[a-z0-9-]+\\.)*youtube\\.com_/|app\\.zoom\\.us_/wc/home)" },
    opacity = "1.0 1.0",
})

-- Floating windows
hl.window_rule({
    name  = "tag-floating-apps",
    match = { class = "(org.omarchy.bluetui|org.omarchy.impala|org.omarchy.wiremix|org.omarchy.btop|org.omarchy.terminal|org.omarchy.bash|org.gnome.NautilusPreviewer|org.gnome.Evince|com.gabm.satty|Omarchy|About|TUI.float|imv|mpv)" },
    tag   = "+floating-window",
})
hl.window_rule({
    name = "tag-floating-file-dialogs",
    match = {
        class = "(xdg-desktop-portal-gtk|sublime_text|DesktopEditors|org.gnome.Nautilus)",
        title = "^(Open.*Files?|Open [F|f]older.*|Save.*Files?|Save.*As|Save|All Files|.*wants to [open|save].*|[C|c]hoose.*)",
    },
    tag = "+floating-window",
})
hl.window_rule({
    name  = "float-floating-window",
    match = { tag = "floating-window" },
    float = true,
})
hl.window_rule({
    name   = "center-floating-window",
    match  = { tag = "floating-window" },
    center = true,
})
hl.window_rule({
    name  = "size-floating-window",
    match = { tag = "floating-window" },
    size  = { 875, 600 },
})
hl.window_rule({
    name  = "float-calculator",
    match = { class = "org.gnome.Calculator" },
    float = true,
})
hl.window_rule({
    name  = "size-calculator",
    match = { class = "org.gnome.Calculator" },
    size  = { 707, 747 },
})

-- Screensaver
hl.window_rule({
    name       = "screensaver-fullscreen",
    match      = { class = "org.omarchy.screensaver" },
    fullscreen = true,
})
hl.window_rule({
    name  = "screensaver-float",
    match = { class = "org.omarchy.screensaver" },
    float = true,
})

-- No transparency on media
hl.window_rule({
    name    = "opaque-media-apps",
    match   = { class = "^(zoom|vlc|mpv|org.kde.kdenlive|com.obsproject.Studio|com.github.PintaProject.Pinta|imv|org.gnome.NautilusPreviewer)$" },
    opacity = "1.0 1.0",
})

-- Popped window rounding
hl.window_rule({
    name     = "pop-rounding",
    match    = { tag = "pop" },
    rounding = 8,
})

-- Prevent idle while open
hl.window_rule({
    name         = "noidle",
    match        = { tag = "noidle" },
    idle_inhibit = "always",
})

-- App-specific rules
hl.window_rule({
    name  = "float-dwarf-things-class",
    match = { class = "dwarf_things" },
    float = true,
})
hl.window_rule({
    name  = "float-dwarf-things-title",
    match = { title = "Dwarf Things" },
    float = true,
})

hl.window_rule({
    name    = "opaque-zed",
    match   = { class = "dev.zed.Zed" },
    opacity = "1.0 1.0",
})

hl.window_rule({
    name = "tag-floating-file-upload",
    match = {
        class = "^(xdg-desktop-portal-gtk)$",
        title = ".*File Upload.*",
    },
    tag = "+floating-window",
})

hl.window_rule({
    name     = "min_size_for_floating",
    match    = { float = true, class = ".*[Bb]lender.*" },
    min_size = { 800, 600 },
})

hl.window_rule({
    name     = "steam-friends-list",
    match    = { class = "steam", title = "Friends List" },
    min_size = { 300, 300 },
    max_size = { 300, 600 },
    size     = { 300, 600 },
})

-- Steam main window: always start floating, never fullscreen
hl.window_rule({
    name       = "steam-main-window",
    match      = { class = "^steam$", title = "^Steam$" },
    float      = true,
    fullscreen = false,
    size       = { 1670, 1086 },
    center     = true,
})

-- Disable animations for walker
hl.layer_rule({
    name    = "walker-no-anim",
    match   = { namespace = "walker" },
    no_anim = true,
})

-- NOTE: the screencopy/picker settings stay in ~/.config/hypr/xdph.conf.
-- That file is xdg-desktop-portal-hyprland's own (hyprlang) config, not
-- sourced by Hyprland, and Hyprland 0.56 has no screencopy config section.
