-- Autostart
-- Runs once at Hyprland startup (replaces exec-once).
-- hl.exec_cmd spawns asynchronously, no need for trailing & / disown.

hl.on("hyprland.start", function()
    hl.exec_cmd("uwsm-app -- mako")
    hl.exec_cmd("uwsm-app -- swaybg -i ~/.config/omarchy/current/background -m fill")
    hl.exec_cmd("uwsm-app -- swayosd-server")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- Slow app launch fix -- set systemd vars
    hl.exec_cmd("systemctl --user import-environment $(env | cut -d'=' -f1)")
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")

    hl.exec_cmd("qs -c noctalia-shell")
end)
