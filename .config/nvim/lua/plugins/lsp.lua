return {
    'nvim-lspconfig',
    event = 'BufReadPost',
    keys = {
    },
    after = function()
        require'lspconfig'.clangd.setup{}
    end
}
