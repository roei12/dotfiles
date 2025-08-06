return {
    'nvim-surround',
    event = 'BufReadPost',
    after = function()
        require'nvim-surround'.setup()
    end,
}
