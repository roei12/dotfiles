return {
    {
        'nvim-lspconfig',
        lazy = false,
        after = function()
            vim.lsp.enable('clangd')
            vim.lsp.enable('gleam')
            vim.lsp.enable('lua_ls')
            vim.lsp.enable('gopls')
            vim.lsp.enable('pyright')
            vim.lsp.enable('rust_analyzer')
        end,
    },
}
