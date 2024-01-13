local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = {
    defaults = {
        lazy = true,
    },
    change_detection = {
        notify = false,
    },
    performance = {
        disabled_plugins = {
            "tutor",
        },
    },
}
require'lazy'.setup("plugins", lazy_config)
