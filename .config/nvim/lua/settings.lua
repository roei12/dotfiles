local v = vim
local opt = v.opt
local api = v.api

vim.g.mapleader = " "

v.g.loaded_ruby_provider = 0
v.g.loaded_python3_provider = 0
v.g.loaded_node_provider = 0
v.g.loaded_perl_provider = 0

opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 0
opt.autoindent = true
opt.smarttab = true

opt.scrolloff = 8

opt.splitbelow = true
opt.splitright = true

opt.number = true
opt.relativenumber = true

api.nvim_set_var('g:netrw_banner', 0);
api.nvim_set_var('g:netrw_hide', 0);
api.nvim_set_var('g:netrw_hide', 0);

v.g.colorcolumn = 100
opt.pumheight = 15

vim.api.nvim_create_autocmd('TextYankPost', { command = 'lua vim.highlight.on_yank {timeout=100}'})

