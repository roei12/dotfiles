local set_hl = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none", nocombine = true })
    vim.api.nvim_set_hl(0, "SnacksPicker", { bg = "none", nocombine = true })
    vim.api.nvim_set_hl(0, "SnacksPickerBorder", { bg = "none", nocombine = true })
    vim.api.nvim_set_hl(0, "SnacksBackdrop_T", { bg = "none", nocombine = true })
end

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
        vim.g.snacks_dim = false
        require('snacks').setup {
            indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            rename = { enabled = true },
            words = { enabled = true },
            zen = { enabled = true },
            notifier = { enabled = true },
        }
        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "*",
            callback = set_hl
        })
        set_hl()
    end,
}
