return {
    {
        'nvim-lspconfig',
        lazy = false,
        after = function()
            local capabilities = require(vim.g.cmp_plugin).get_lsp_capabilities()
            local lsp = vim.lsp

            lsp.config('*', {
                capabilities = capabilities,
            })

            lsp.enable('clangd')
            lsp.enable('gleam')
            lsp.enable('lua_ls')
            lsp.enable('gopls')
            lsp.enable('pyright')
            lsp.enable('rust_analyzer')
        end,
    },
}
