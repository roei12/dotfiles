return {
    'snacks.nvim',
    lazy = false,
    keys = {
        -- picker
        { '<leader>ff', function() Snacks.picker.files() end, },
        { '<leader>fg', function() Snacks.picker.grep() end, },
        { '<leader>fr', function() Snacks.picker.lsp_references() end, },
        { '<leader>fs', function() Snacks.picker.lsp_workspace_symbols() end, },

        -- zen mode
        { '<leader>zz', function() Snacks.zen() end, },

        -- words
        -- maybe map * somehow

    },
    after = function()
        -- disable animations
        vim.g.snacks_animate = false
        require('snacks').setup {
            indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            rename = { enabled = true },
            words = { enabled = true },
            zen = { enabled = true, toggle = { dim = false } },
            notifier = { enabled = true },
            -- bigfile = { enabled = false },
            -- dashboard = { enabled = false },
            -- explorer = { enabled = false },
            -- quickfile = { enabled = false },
            -- scope = { enabled = false },
            -- scroll = { enabled = false },
            -- statuscolumn = { enabled = false },
        }
    end,
}
