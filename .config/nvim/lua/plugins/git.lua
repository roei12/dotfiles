return {
    {
        'vim-fugitive',
        cmd = 'Git',
        keys = {
            {'<leader>G', vim.cmd.Git},
            {'<leader>gp', function() vim.cmd.Git('pull') end},
            {'<leader>gP', function() vim.cmd.Git('push') end},
            {'<leader>gc', function() vim.cmd.Git('commit') end},
            {'<leader>ga', vim.cmd.Gwrite},
            {'<leader>gR', vim.cmd.Gread},
        },
    },
    {
        'gitsigns.nvim',
        lazy = false,
        after = function() require'gitsigns'.setup() end,
    },
}
