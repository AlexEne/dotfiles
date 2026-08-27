-- Clipboard bindings

hl.bind("SUPER + C", hl.dsp.send_shortcut({ mods = "CTRL",  key = "Insert" }))
hl.bind("SUPER + V", hl.dsp.send_shortcut({ mods = "SHIFT", key = "Insert" }))
hl.bind("SUPER + X", hl.dsp.send_shortcut({ mods = "CTRL",  key = "X" }))

hl.bind("SUPER + CTRL + V", hl.dsp.exec_cmd("walker -m clipboard --width 644 --maxheight 300 --minheight 300"))
