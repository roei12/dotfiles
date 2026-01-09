vim.g.ai_term_buf_provider = {
    last_buf = nil,
    claude_buf = nil,
    job_id = nil,
}

local term_buf_provider = {}
local self = vim.g.ai_term_buf_provider
local api = vim.api

function term_buf_provider.setup(_)
    -- Setup a new buffer for the agent

    term_buf_provider.close()
    self.claude_buf = api.nvim_create_buf(false, true)

    vim.keymap.set("t", "jk", term_buf_provider._toggle, { buffer = self.claude_buf })
end

function term_buf_provider.open(cmd_string, env_table, _, focus)
    -- Open terminal with command and environment
    -- focus parameter controls whether to focus terminal (defaults to true)

    if self.claude_buf and self.job_id then
        if not api.nvim_buf_is_valid(self.claude_buf) then
            term_buf_provider.close()
        elseif focus and not api.nvim_get_current_buf() == self.claude_buf then
            term_buf_provider._toggle()
            return
        else
            -- nothing to do
            return
        end
    elseif not self.claude_buf then
        term_buf_provider.setup {}
    end


    local term_opts = {
        -- clear_env = true,
        env = env_table,
        on_exit = function(job_id, _, _)
            if job_id == self.job_id then
                term_buf_provider.close()
            end
        end
    }

    self.bg_buf = api.nvim_get_current_buf()
    api.nvim_set_current_buf(self.claude_buf)
    vim.cmd.startinsert()
    self.job_id = vim.fn.termopen(cmd_string, term_opts)


    if focus == false then
        term_buf_provider._toggle()
    end
end

function term_buf_provider.close()
    -- Close the terminal

    vim.notify("close called")
    local current_buf = api.nvim_get_current_buf()
    if current_buf == self.claude_buf then
        term_buf_provider._toggle()
    end

    if self.job_id then
        vim.fn.jobstop(self.job_id)
        self.job_id = nil
    end

    if self.claude_buf and api.nvim_buf_is_valid(self.claude_buf) then
        api.nvim_buf_delete(self.claude_buf, { force = true })
        self.claude_buf = nil
    end
end

function term_buf_provider.simple_toggle(cmd_string, env_table, effective_config)
    -- Simple show/hide toggle
    -- Nothing to show/hide when using buffers, only focus makes sense

    term_buf_provider.focus_toggle(cmd_string, env_table, effective_config)
end

function term_buf_provider.focus_toggle(cmd_string, env_table, effective_config)
    -- Smart toggle: focus terminal if not focused, hide if focused

    -- calling open to make sure we have an instance running
    term_buf_provider.open(cmd_string, env_table, effective_config, false)
    term_buf_provider._toggle()
end

function term_buf_provider._toggle()
    local current_buf = api.nvim_get_current_buf()
    if current_buf == self.claude_buf then
        api.nvim_set_current_buf(self.bg_buf)
        self.bg_buf = nil
    else
        self.bg_buf = api.nvim_get_current_buf()
        api.nvim_set_current_buf(self.claude_buf)
        vim.cmd.startinsert()
    end
end

function term_buf_provider.get_active_bufnr()
    -- Return terminal buffer number or nil

    -- make sure that we don't return garbage
    if self.claude_buf and not api.nvim_buf_is_valid(self.claude_buf) then
        term_buf_provider.close()
    end

    return self.claude_buf
end

function term_buf_provider.is_available()
    -- Return true if provider can be used
    return true
end

return {
    'claudecode.nvim',
    lazy = true,
    after = function()
        require('claudecode').setup {
            terminal = {
                provider = term_buf_provider,
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
