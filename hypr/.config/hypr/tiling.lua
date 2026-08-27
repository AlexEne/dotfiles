-- Tiling / window management bindings

-- Close windows
hl.bind("SUPER + W", hl.dsp.window.close())
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("~/.config/hypr/scripts/close-all-windows.sh"))

-- Control tiling
hl.bind("SUPER + J", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + P", hl.dsp.window.pseudo())
hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind("SUPER + CTRL + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 2 }))
hl.bind("SUPER + ALT + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind("SUPER + O", hl.dsp.exec_cmd("~/.config/hypr/scripts/window-pop.sh"))

-- Move focus with SUPER + arrow keys
hl.bind("SUPER + left",  hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + up",    hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + down",  hl.dsp.focus({ direction = "d" }))

-- Workspaces with SUPER + [1-9; 0] (keycodes, layout-independent)
-- SUPER + SHIFT: move window to workspace (follow)
-- SUPER + SHIFT + ALT: move window silently (don't follow)
for i = 1, 10 do
    local code = 9 + i -- code:10 = key 1 ... code:19 = key 0
    hl.bind("SUPER + code:" .. code,               hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + code:" .. code,       hl.dsp.window.move({ workspace = i, follow = true }))
    hl.bind("SUPER + SHIFT + ALT + code:" .. code, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Control scratchpad
hl.bind("SUPER + S",       hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind("SUPER + ALT + S", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))

-- TAB between workspaces
hl.bind("SUPER + TAB",        hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + CTRL + TAB", hl.dsp.focus({ workspace = "previous" }))

-- Move workspaces to other monitors
hl.bind("SUPER + SHIFT + ALT + left",  hl.dsp.workspace.move({ monitor = "l" }))
hl.bind("SUPER + SHIFT + ALT + right", hl.dsp.workspace.move({ monitor = "r" }))
hl.bind("SUPER + SHIFT + ALT + up",    hl.dsp.workspace.move({ monitor = "u" }))
hl.bind("SUPER + SHIFT + ALT + down",  hl.dsp.workspace.move({ monitor = "d" }))

-- Swap windows
hl.bind("SUPER + SHIFT + left",  hl.dsp.window.swap({ direction = "l" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.swap({ direction = "r" }))
hl.bind("SUPER + SHIFT + up",    hl.dsp.window.swap({ direction = "u" }))
hl.bind("SUPER + SHIFT + down",  hl.dsp.window.swap({ direction = "d" }))

-- Cycle through applications
hl.bind("ALT + TAB",        hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + TAB", hl.dsp.window.cycle_next({ next = false }))
hl.bind("ALT + TAB",        hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind("ALT + SHIFT + TAB", hl.dsp.window.alter_zorder({ mode = "top" }))

-- Resize active window
hl.bind("SUPER + code:20",        hl.dsp.window.resize({ x = -100, y = 0,    relative = true }))
hl.bind("SUPER + code:21",        hl.dsp.window.resize({ x = 100,  y = 0,    relative = true }))
hl.bind("SUPER + SHIFT + code:20", hl.dsp.window.resize({ x = 0,    y = -100, relative = true }))
hl.bind("SUPER + SHIFT + code:21", hl.dsp.window.resize({ x = 0,    y = 100,  relative = true }))

-- Scroll through workspaces with SUPER + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with SUPER + LMB/RMB
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Toggle groups
hl.bind("SUPER + G",       hl.dsp.group.toggle())
hl.bind("SUPER + ALT + G", hl.dsp.window.move({ out_of_group = true }))

-- Join groups
hl.bind("SUPER + ALT + left",  hl.dsp.window.move({ into_group = "l" }))
hl.bind("SUPER + ALT + right", hl.dsp.window.move({ into_group = "r" }))
hl.bind("SUPER + ALT + up",    hl.dsp.window.move({ into_group = "u" }))
hl.bind("SUPER + ALT + down",  hl.dsp.window.move({ into_group = "d" }))

-- Navigate grouped windows
hl.bind("SUPER + ALT + TAB",        hl.dsp.group.next())
hl.bind("SUPER + ALT + SHIFT + TAB", hl.dsp.group.prev())

hl.bind("SUPER + CTRL + left",  hl.dsp.group.prev())
hl.bind("SUPER + CTRL + right", hl.dsp.group.next())

hl.bind("SUPER + ALT + mouse_down", hl.dsp.group.next())
hl.bind("SUPER + ALT + mouse_up",   hl.dsp.group.prev())

for i = 1, 5 do
    hl.bind("SUPER + ALT + code:" .. (9 + i), hl.dsp.group.active({ index = i }))
end
