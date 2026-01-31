local wez_pane = vim.g._utils.wezterm_provider

return {
    'claudecode.nvim',
    lazy = true,
    after = function()
        vim.api.nvim_create_autocmd("FocusLost", {
            pattern = "*",
            callback = function()
                -- vim.notify("focus lost!")
                -- wez_pane:fix_focus()
            end,
        })
        require('claudecode').setup {
            terminal_cmd = "/opt/homebrew/bin/claude --ide",
            terminal = {
                split_width_percentage = 0.6,
                provider = {
                    -- Required functions
                    setup = function(config)
                        return wez_pane:setup(config)
                    end,

                    open = function(cmd_string, env_table, effective_config, focus)
                        -- Open terminal with command and environment
                        -- focus parameter controls whether to focus terminal (defaults to true)
                        return wez_pane:open(cmd_string, env_table, effective_config, focus)
                    end,

                    close = function()
                        -- Close the terminal
                        return wez_pane:close()
                    end,

                    simple_toggle = function(cmd_string, env_table, effective_config)
                        -- Simple show/hide toggle
                        return wez_pane:simple_toggle(cmd_string, env_table, effective_config)
                    end,

                    focus_toggle = function(cmd_string, env_table, effective_config)
                        -- Smart toggle: focus terminal if not focused, hide if focused
                        return wez_pane:focus_toggle(cmd_string, env_table, effective_config)
                    end,

                    get_active_bufnr = function()
                        -- Return terminal buffer number or nil
                        return wez_pane:get_active_bufnr()
                    end,

                    is_available = function()
                        -- Return true if provider can be used
                        return wez_pane:is_available()
                    end,
                },
            },
        }
    end,
    cmd = {
        'ClaudeCode',
        'ClaudeCodeOpen',
        'ClaudeCodeFocus',
        'ClaudeCodeSend',
    },
    keys = {
        { '<leader>aa', '<cmd>ClaudeCodeFocus<CR>', mode = 'n' },
        {
            "<leader>as",
            function()
                vim.cmd.ClaudeCodeTreeAdd()
                wez_pane:_hide()
            end,
            desc = "Add file",
            ft = { "oil" },
        },
        {
            '<leader>ah',
            function()
                wez_pane:_hide()
            end,
            mode = 'n'
        },
        {
            '<leader>aa',
            function()
                vim.cmd("ClaudeCodeSend")
                vim.cmd("ClaudeCodeFocus")
            end,
            mode = 'v'
        },
        { '<leader>as', '<cmd>ClaudeCodeSend<CR>',  mode = 'v' },
    }
}
