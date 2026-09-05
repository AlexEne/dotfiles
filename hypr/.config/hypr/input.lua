-- Input devices

hl.config({
    input = {
        kb_layout          = "us",
        kb_variant         = "",
        kb_model           = "",
        kb_options         = "ctrl:nocaps",
        kb_rules           = "",
        follow_mouse       = 1,
        repeat_rate        = 40,
        repeat_delay       = 500,
        numlock_by_default = true,
        sensitivity        = -0.3,
        accel_profile      = "flat",
        touchpad = {
            natural_scroll = false,
            scroll_factor  = 0.4,
        },
    },

    misc = {
        key_press_enables_dpms = true,
        mouse_move_enables_dpms = true,
    },
})

-- Faster touchpad scrolling in Ghostty
hl.window_rule({
    name           = "ghostty-scroll-factor",
    match          = { class = "com.mitchellh.ghostty" },
    scroll_touchpad = 2.2,
})
