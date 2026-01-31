return {
    'oil.nvim',
    lazy = false,
    keys = {
        { '<leader>e', vim.cmd.Oil },
        -- keymaps = {
        --     ["g?"] = { "actions.show_help", mode = "n" },
        --     ["<CR>"] = "actions.select",
        --     ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        --     ["<C-t>"] = { "actions.select", opts = { tab = true } },
        --     ["<C-p>"] = "actions.preview",
        --     ["<C-c>"] = { "actions.close", mode = "n" },
        --     ["-"] = { "actions.parent", mode = "n" },
        --     ["_"] = { "actions.open_cwd", mode = "n" },
        --     ["`"] = { "actions.cd", mode = "n" },
        --     ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        --     ["gs"] = { "actions.change_sort", mode = "n" },
        --     ["gx"] = "actions.open_external",
        --     ["g."] = { "actions.toggle_hidden", mode = "n" },
        --     ["g\\"] = { "actions.toggle_trash", mode = "n" },
        -- }
    },
    after = function()
        require 'oil'.setup {
            use_default_keymaps = true,
            keymaps = {
                ["<C-l>"] = false,
                ["<C-h>"] = false,
            },
        }

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
