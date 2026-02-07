local tab_bar = require('tab_bar')
local wezterm = require('wezterm')
local M = {}

function M.apply(config)
    config.color_scheme = 'Gruvbox dark, hard (base16)'
    local scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]

    config.font_size = 16
    if wezterm.target_triple:find("darwin") ~= nil then
        config.window_background_opacity = 0.85
        config.macos_window_background_blur = 20
    end

    config.window_decorations = "NONE"
    config.use_fancy_tab_bar = false
    config.tab_max_width = 32
    config.tab_bar_style = {
        new_tab = ''
    }
    config.colors = {
        tab_bar = {
            active_tab = {
                bg_color = scheme.brights[5],
                fg_color = scheme.background,
            },
            background = scheme.background,
        }
    }

    wezterm.on(
        'format-tab-title',
        tab_bar.get_formatter(config)
    )
end

return M
