vim.keymap.set('i', 'jk', '<Esc>l')
vim.keymap.set('n', '<leader>e', vim.cmd.Explore)

vim.keymap.set({'n', 'v'}, '<leader>p', '"+p')
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y')

vim.keymap.set('n', '<leader>ff', function() require'telescope.builtin'.find_files() end);
vim.keymap.set('n', '<leader>fg', function() require'telescope.builtin'.live_grep() end);
vim.keymap.set('n', '<leader>fw', function() require'telescope.builtin'.grep_string({search = vim.fn.expand'<cword>'}) end);
