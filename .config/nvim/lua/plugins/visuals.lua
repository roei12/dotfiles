return {
    {
        'darkbox.nvim',
        lazy = false,
        after = function()
            require('darkbox').load()
            vim.cmd.colorscheme('darkbox')
        end
    },
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
