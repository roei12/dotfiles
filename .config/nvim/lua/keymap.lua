-- exit insert mode with style
vim.keymap.set('i', 'jk', '<Esc>l')

-- Clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')


vim.keymap.set({ 'n' }, '<leader>c', vim.cmd.bd)

-- Git
vim.keymap.set({ 'n' }, '<leader>G', vim.cmd.Git)
vim.keymap.set({ 'n' }, '<leader>gha', function()
    vim.cmd.Gitsigns("stage_hunk")
end)

-- Lsp
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufopts = { noremap = true, silent = true, buffer = args.buf }
        vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, bufopts)
        vim.keymap.set('n', 'gl', vim.diagnostic.open_float, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    end
})
