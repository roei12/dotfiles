-- exit insert mode with style
vim.keymap.set('i', 'jk', '<Esc>l')

-- Clipboard
vim.keymap.set({'n', 'v'}, '<leader>p', '"+p')
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y')

-- Git
vim.keymap.set({'n'}, '<leader>G', vim.cmd.Git)

-- Lsp
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufopts = { noremap = true, silent = true, buffer = args.buf }
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, bufopts)
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, bufopts)
  end
})

