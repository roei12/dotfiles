return {
    'blink.cmp',
    event = 'InsertEnter',
    beforeAll = function()
        vim.g.cmp_plugin = 'blink.cmp'
    end,
    after = function()
        require'blink.cmp'.setup{

            keymap = {
                preset = 'enter',
                ['<C-Space>'] = {},
            },
        }
    end,
}
