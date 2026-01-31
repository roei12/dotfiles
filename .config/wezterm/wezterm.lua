---@type Wezterm
local wezterm = require('wezterm')
local config = wezterm.config_builder()

require('keybinds').apply(config)
require('visuals').apply(config)


return config
