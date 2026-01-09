local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.keys = require('keybinds')
config.colors = require('colors.darkbox')

config.color_scheme = 'Gruvbox Dark (Gogh)'

config.font_size = 14

config.leader = { key = ' ', mods = 'ALT', timeout_milliseconds = 1000 }

return config
