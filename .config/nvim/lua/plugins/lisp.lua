vim.o.runtimepath = vim.o.runtimepath .. ",~/.local/share/nvim/site/pack/rocks/opt/vlime/vim"
return {
    {
        'vlime',
        lazy = true,
        ft = 'lisp',
    },
    {
        'predit',
        lazy = true,
        ft = 'lisp',
    },
}
