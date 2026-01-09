local v = vim
local opt = v.opt

vim.g.mapleader = " "
vim.g.localleader = ","
vim.o.termguicolors = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.undofile = true
vim.o.swapfile = false

vim.o.cole = 2
vim.o.cocu = 'n'

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

v.g.netrw_banner = 0
v.g.netrw_hide = 0

v.g.colorcolumn = 100
opt.pumheight = 15

vim.diagnostic.config {
    virtual_text     = true,
    signs            = true,
    underline        = true,
    update_in_insert = false,
    severity_sort    = true,
}

vim.api.nvim_create_autocmd('TextYankPost', { command = 'lua vim.highlight.on_yank {timeout=100}' })

-- auto formatting on save
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end
        })
    end
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ''
-- vim.opt.fillchars = 'fold: '
vim.opt.foldlevelstart = 99
