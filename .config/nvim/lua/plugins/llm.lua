return {
    {
        'codecompanion',
        lazy = true,
        cmd = 'CodeCompanion',
        keys = {
            -- GPT Pane Toggle
            {'<leader>gpt', ":CodeCompanionChat Toggle" },
        },
        after = function()
            require'codecompanion'.setup({
                strategies = {
                    chat = {
                        adapter = "gemini",
                    },
                    -- chat = {
                    --     adapter = "openai",
                    -- },
                    -- chat = {
                    --     adapter = "anthropic",
                    -- },
                },
            })
        end,
    },
}
