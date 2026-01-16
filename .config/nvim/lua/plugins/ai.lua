return {
    'claudecode.nvim',
    lazy = true,
    event = 'LspAttach', -- Load with lsp
    after = function()
        require('claudecode').setup {
            terminal = {
                provider = 'none',
            },
        }
    end,
    cmd = {
        'ClaudeCode',
        'ClaudeCodeOpen',
        'ClaudeCodeFocus',
        'ClaudeCodeSend',
    },
    keys = {
        { '<leader>aa', '<cmd>ClaudeCode<CR>',     mode = 'n' },
        { '<leader>as', '<cmd>ClaudeCodeSend<CR>', mode = 'v' },
    }
}
