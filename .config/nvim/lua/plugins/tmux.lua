return {
    {
        'wezterm.nvim',
        lazy = false,
        after = function()
            require('wezterm').setup {
                create_commands = false,
            }
        end,
    },
    {
        'smart-splits.nvim',
        lazy = false,
        keys = {
            {
                "<c-h>",
                function()
                    local wezterm = require('wezterm')
                    local pane_id = wezterm.get_current_pane()
                    wezterm.zoom_pane(pane_id, { unzoom = true })
                    require('smart-splits').move_cursor_left()
                end
            },
            {
                "<c-j>",
                function()
                    local wezterm = require('wezterm')
                    local pane_id = wezterm.get_current_pane()
                    wezterm.zoom_pane(pane_id, { unzoom = true })
                    require('smart-splits').move_cursor_down()
                end
            },
            {
                "<c-k>",
                function()
                    local wezterm = require('wezterm')
                    local pane_id = wezterm.get_current_pane()
                    wezterm.zoom_pane(pane_id, { unzoom = true })
                    require('smart-splits').move_cursor_up()
                end
            },
            {
                "<c-l>",
                function()
                    local wezterm = require('wezterm')
                    local pane_id = wezterm.get_current_pane()
                    wezterm.zoom_pane(pane_id, { unzoom = true })
                    require('smart-splits').move_cursor_right()
                end
            },
        },
    },
}
