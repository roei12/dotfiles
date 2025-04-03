return {
    'oil.nvim',
    lazy = false,
    keys = {
        {'<leader>e', vim.cmd.Oil},
    },
    after = function() require'oil'.setup() end,
}
