return {
    'telescope.nvim',
    keys = {
        {'<leader>ff', "<CMD>Telescope find_files<CR>"},
        {'<leader>fg', "<CMD>Telescope live_grep<CR>"},
        {'<leader>fr', "<CMD>Telescope lsp_references<CR>"},
    },
    after = function()
        require'telescope'.setup{}
    end,
}
