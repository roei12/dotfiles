return {
    'nvim-lspconfig',
    event = 'BufReadPost',
    after = function()
        local capabilities = require(vim.g.cmp_plugin).get_lsp_capabilities()
        require'lspconfig'.clangd.setup{ capabilities = capabilities }
    end
}
