return {
    {
        'gruvbox-material',
        lazy = false,
        after = function()
            vim.g.gruvbox_material_enable_italics = true
            vim.g.gruvbox_material_background = 'hard'
            if vim.g.transparent_bg then
                vim.g.gruvbox_material_transparent_background = 1
            end
            vim.cmd.colorscheme('gruvbox-material')
        end
    },
    {
        'nvim-treesitter-context',
        lazy = true,
        event = 'BufReadPost',
        after = function()
            require 'treesitter-context'.setup {
                enable = true,
            }
        end,
    },
}
