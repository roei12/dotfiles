return {
    {
        'vim-fugitive',
        -- cmd = 'Git',
        lazy = false,
        keys = {
            {'<leader>G', vim.cmd.Git},
            {'<leader>gP', function() vim.cmd.Git('pull') end},
            {'<leader>gp', function() vim.cmd.Git('push') end},
            {'<leader>gc', function() vim.cmd.Git('commit') end},
            {'<leader>ga', vim.cmd.Gwrite},
            {'<leader>gR', vim.cmd.Gread},
        },
    },
    {
        'gitsigns.nvim',
        lazy = false,
        keys = {
            {'<leader>ghv', function() vim.cmd.Gitsigns("preview_hunk") end},
            {'<leader>gha', function() vim.cmd.Gitsigns("stage_hunk") end},
        },
        after = function() require'gitsigns'.setup() end,
    },
}
