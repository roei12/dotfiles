local wezterm = require('wezterm')
local actions = wezterm.action
local split_nav = require('plugins.smart-splits').split_nav

local M = {}

local function map(key, mods, action)
    return {
        mods = mods,
        key = key,
        action = action
    }
end

-- Generate leader map
local lmap = function(key, action)
    return map(key, 'LEADER', action)
end

function M.apply(config)
    config.leader = { key = ' ', mods = 'ALT', timeout_milliseconds = 1000 }
    config.keys = {
        -- splitting
        lmap('-', actions.SplitVertical { domain = 'CurrentPaneDomain' }),
        lmap('\\', actions.SplitHorizontal { domain = 'CurrentPaneDomain' }),

        -- zoom
        lmap('z', actions.TogglePaneZoomState),

        -- copy mode
        lmap('[', actions.ActivateCopyMode),

        -- rename tab
        lmap('n', actions.PromptInputLine {
            description = "Rename Tab to: ",
            action = wezterm.action_callback(function(window, _, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        }),

        -- split resize
        map('h', 'ALT', actions.AdjustPaneSize { "Left", 1 }),
        map('j', 'ALT', actions.AdjustPaneSize { "Down", 1 }),
        map('k', 'ALT', actions.AdjustPaneSize { "Up", 1 }),
        map('l', 'ALT', actions.AdjustPaneSize { "Right", 1 }),

        -- smart-splits
        split_nav('h'),
        split_nav('j'),
        split_nav('k'),
        split_nav('l'),
    }
end

return M
