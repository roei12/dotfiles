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
        'indent-blankline',
        lazy = true,
        event = 'BufReadPost',
        after = function()
            require'ibl'.setup()
        end,
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
