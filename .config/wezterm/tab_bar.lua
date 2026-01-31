---@type Wezterm
local wezterm = require "wezterm"
local M = {}

local function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
        return title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab
    return tab_info.active_pane.title
end

---get tab format function
---@param config Config
---@return function
function M.get_formatter(config)
    local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
    local SOFT_RIGHT_ARROW = wezterm.nerdfonts.pl_left_soft_divider
    local scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]
    local res = function(tab, _, _, _, _, _)
        local result = {}
        local title = tab_title(tab)
        local nth = tab.tab_index + 1

        if tab.is_active then
            local background = config.colors.tab_bar.active_tab.bg_color
            local foreground = config.colors.tab_bar.active_tab.fg_color
            local format = {
                { Background = { Color = background } },
                { Foreground = { Color = foreground } },
                { Text = SOLID_RIGHT_ARROW .. ' ' .. nth .. ' ' .. SOFT_RIGHT_ARROW .. ' ' .. title .. ' ' },
                { Background = { Color = foreground } },
                { Foreground = { Color = background } },
                { Text = SOLID_RIGHT_ARROW },
            }
            for _, val in ipairs(format) do
                table.insert(result, val)
            end
            return result
        else
            local background = scheme.brights[1]
            local foreground = scheme.brights[8]
            local format = {
                { Background = { Color = background } },
                { Foreground = { Color = scheme.background } },
                { Text = SOLID_RIGHT_ARROW },
                { Background = { Color = background } },
                { Foreground = { Color = foreground } },
                { Text = ' ' .. nth .. ' ' .. SOFT_RIGHT_ARROW .. ' ' .. title .. ' ' },
                { Background = { Color = scheme.background } },
                { Foreground = { Color = background } },
                { Text = SOLID_RIGHT_ARROW },
            }
            for _, val in ipairs(format) do
                table.insert(result, val)
            end
            return result
        end
    end
    return res
end

return M
