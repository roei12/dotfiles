return {
    'nvim-surround',
    lazy = true,
    event = 'BufReadPost',
    after = function()
        require'nvim-surround'.setup()
    end,
}
