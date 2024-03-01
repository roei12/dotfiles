return {
    {
        'neovim/nvim-lspconfig',
        lazy = false,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            { "nushell/tree-sitter-nu" },
        },
        lazy = false,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
        cmd = 'Mason',
    },
}
