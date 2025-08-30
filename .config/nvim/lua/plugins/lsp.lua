return {
    {
        'nvim-lspconfig',
        event = 'BufReadPost',
        lazy = true,
        after = function()
            local capabilities = require(vim.g.cmp_plugin).get_lsp_capabilities()
            local lsp = vim.lsp

            lsp.config('*', {
                capabilities = capabilities,
                on_attach = on_attach,
            })

            lsp.enable('clangd')
            lsp.enable('gleam')
            lsp.enable('lua_ls')
            lsp.enable('gopls')
            lsp.enable('pyright')
        end,
    },
}
