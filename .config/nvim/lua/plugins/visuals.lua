return {
    {
        'gruvbox-material',
        lazy = false,
        after = function()
            vim.g.gruvbox_material_enable_italics = true
            vim.g.gruvbox_material_background = 'hard'
            vim.cmd.colorscheme('gruvbox-material')
        end
    },
    -- {
    --     'darkbox.nvim',
    --     lazy = false,
    --     after = function()
    --         require('darkbox').load()
    --         vim.cmd.colorscheme('darkbox')
    --     end
    -- },
    {
        'nvim-treesitter-context',
        lazy = true,
        event = 'BufReadPost',
        after = function()
            require 'treesitter-context'.setup {
                enable = true,
            }
        end,
    },
}
