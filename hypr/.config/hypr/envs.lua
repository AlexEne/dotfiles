-- Environment variables

-- Cursor size
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Force all apps to use Wayland
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("GTK_THEME", "Catppuccin-Dark")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- Desktop environment
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- NVIDIA
hl.env("NVD_BACKEND", "direct")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-- HiDPI - retina displays (monitors.lua overrides)
hl.env("GDK_SCALE", "2")

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

-- Use XCompose file
hl.env("XCOMPOSEFILE", "~/.XCompose")

-- Don't show update on first launch
hl.config({
    ecosystem = {
        no_update_news = true,
    },
})
