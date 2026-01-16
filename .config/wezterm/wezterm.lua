local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.keys = require('keybinds')

config.color_scheme = 'Gruvbox dark, hard (base16)'
config.font_size = 14

config.window_decorations = "NONE"

config.leader = { key = ' ', mods = 'ALT', timeout_milliseconds = 1000 }

return config
