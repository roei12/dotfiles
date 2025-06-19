return {
    {
        'nvim-lspconfig',
        event = 'BufReadPost',
        lazy = false,
        after = function()
            local on_attach = function(client, bufnr)
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, bufopts)
                vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, bufopts)
                vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, bufopts)
                vim.keymap.set('n', 'gl', vim.diagnostic.open_float, bufopts)
            end
            local capabilities = require(vim.g.cmp_plugin).get_lsp_capabilities()
            local lsp = vim.lsp
            lsp.config('*', {
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lsp.enable('clangd')
            lsp.enable('gleam')
            lsp.enable('lua_ls')
        end
    },
}
