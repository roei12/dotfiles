local accept_tab = function()
    require('cursortab').accept()
end
return {
    'cursortab.nvim',
    lazy = true,
    event = "InsertEnter",
    keys = {
        {
            '<leader>at',
            accept_tab,
            mode = 'n'
        },
        {
            '<Tab>',
            accept_tab,
            mode = "i"
        },
    },
    after = function()
        require('cursortab').setup {
            log_level = "warn",
            keymaps = {
                accept = false,
            },
            provider = {
                type = "sweep",
                url = "http://localhost:1234",
                api_key_env = "LOCAL_LLM_KEY",
                model = "sweep-next-edit-1.5b-mlx",
            },
        }
    end
}
