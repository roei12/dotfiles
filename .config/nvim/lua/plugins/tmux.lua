return {
    'smart-splits.nvim',
    lazy = false,
    keys = {
        { "<c-h>", require('smart-splits').move_cursor_left },
        { "<c-j>", require('smart-splits').move_cursor_down },
        { "<c-k>", require('smart-splits').move_cursor_up },
        { "<c-l>", require('smart-splits').move_cursor_right },
    },
}
