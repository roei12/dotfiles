return {
    'nvim-lspconfig',
    event = 'BufReadPost',
    after = function()
        local on_attach = function(client, bufnr)
            local bufopts = { noremap=true, silent=true, buffer=bufnr }
            vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, bufopts)
        end
        local capabilities = require(vim.g.cmp_plugin).get_lsp_capabilities()
        require'lspconfig'.clangd.setup{ on_attach=on_attach, capabilities = capabilities }
    end
}
