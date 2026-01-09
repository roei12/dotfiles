return {
    'oil.nvim',
    lazy = false,
    keys = {
        { '<leader>e', vim.cmd.Oil },
    },
    after = function()
        require 'oil'.setup()
        vim.api.nvim_create_autocmd("User", {
            pattern = "OilActionsPost",
            callback = function(event)
                if event.data.actions[1].type == "move" then
                    Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
                end
            end,
        })
    end,
}
