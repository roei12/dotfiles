return {
    {
        'nvim-lspconfig',
        lazy = false,
        after = function()
            vim.lsp.enable('terraformls')
            vim.lsp.enable('clangd')
            vim.lsp.enable('gleam')
            vim.lsp.enable('lua_ls')
            vim.lsp.enable('gopls')
            vim.lsp.config('pyright', {
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "Strict",
                        },
                    },
                },
                on_attach = function(client, _)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
            })
            vim.lsp.enable('pyright')
            vim.lsp.config('ruff', {
                on_attach = function(client, _)
                    client.server_capabilities.documentFormattingProvider = true
                end

            })
            vim.lsp.enable('ruff')
            vim.lsp.config('rust_analyzer', {
                settings = {
                    ['rust-analyzer'] = {
                        check = {
                            command = "clippy"
                        }
                    }
                }
            })
            vim.lsp.enable('rust_analyzer')
        end,
    },
}
