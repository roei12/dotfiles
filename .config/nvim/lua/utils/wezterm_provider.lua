local M = {}
local wezterm = require('wezterm')

local function notify(msg)
    vim.notify("WeztermProvider: " .. msg)
end

function M:get_nvim_pane()
    if self.nvim_pane ~= nil then
        return self.nvim_pane
    end

    local pane_id = wezterm.get_current_pane()

    self.nvim_pane = wezterm.get_pane(pane_id)
    return self.nvim_pane
end

function M:ensure_claude()
    for _, pane in ipairs(wezterm.list_panes()) do
        if
            self.claude_pane == nil and
            self:get_nvim_pane().tab_id == pane.tab_id and
            string.find(pane.title, "Claude")
        then
            self.claude_pane = pane
            return true
        elseif
            self.claude_pane ~= nil and
            pane.pane_id == self.claude_pane.pane_id
        then
            -- update pane
            self.claude_pane = pane
            return true
        end
    end

    return false
end

function M:setup(term_config)
    -- Setup a new buffer for the agent
    self.nvim_pane = nil
    self._claude_width = nil
    self.config = term_config
end

function M:open(cmd_string, _, effective_config, focus)
    -- Open terminal with command and environment
    -- focus parameter controls whether to focus terminal (defaults to true)

    if not self:ensure_claude() then
        self:close()
    elseif focus and wezterm.get_current_pane() ~= self.claude_pane.pane_id then
        self:simple_toggle(cmd_string, {}, effective_config)
        return
    else
        -- valid and focuesd
        return
    end

    local term_cmd_arg
    if cmd_string:find(" ", 1, true) then
        term_cmd_arg = vim.split(cmd_string, " ", { plain = true, trimempty = false })
    else
        term_cmd_arg = { cmd_string }
    end

    local pane_settings = {
        cwd = effective_config.cwd,
        program = term_cmd_arg,
        percent = effective_config.split_width_percentage * 100,
        left = effective_config.split_side == "left",
        right = effective_config.split_side == "right",
    }

    local pane_id = wezterm.split_pane.horizontal(pane_settings)
    self.claude_pane = wezterm.get_pane(pane_id)
    self.claude_hidden = false
    assert(self:ensure_claude(), "ensure claude failed right after opening")
end

function M:close()
    -- Close the terminal

    if not self:ensure_claude() then
        return
    end

    if wezterm.get_current_pane() == self.claude_pane.pane_id then
        wezterm.switch_pane.id(self.nvim_pane.pane_id)
    end

    wezterm.exec({ "cli", "kill-pane", "--pane-id", self.claude_pane.pane_id },
        function() self.claude_pane.pane_id = nil end)
end

function M:simple_toggle(cmd_string, env_table, effective_config)
    -- Simple show/hide toggle
    -- calling open to make sure we have an instance running
    self:open(cmd_string, env_table, effective_config, true)

    if self.claude_hidden then
        self:_show()
    else
        self:_hide()
    end
end

function M:focus_toggle(cmd_string, env_table, effective_config)
    -- Smart toggle: focus terminal if not focused, hide if focused

    -- calling open to make sure we have an instance running
    self:open(cmd_string, env_table, effective_config, false)
    local current_pane_id = wezterm.get_current_pane()

    if current_pane_id ~= self.claude_pane.pane_id then
        wezterm.switch_pane.id(self.claude_pane.pane_id)
        self:_show()
    else
        wezterm.switch_pane.id(self.nvim_pane.pane_id)
        self:_hide()
    end
end

function M:send_text(text)
    if not self:ensure_claude() then
        return
    end
    wezterm.send_text(text, self.claude_pane.pane_id, true)
end

function M:_hide()
    wezterm.exec_sync { "cli", "adjust-pane-size", "--pane-id", self.claude_pane.pane_id, "--amount", self._claude_width, "right" }
    self.claude_hidden = true
end

function M:_show()
    wezterm.exec_sync { "cli", "adjust-pane-size", "--pane-id", self.claude_pane.pane_id, "--amount", self._claude_width, "left" }
    self.claude_hidden = false
end

function M:fix_focus()
    assert(self:ensure_claude(), "ensure cloud failed on fix_focus")
    local current_pane_id = wezterm.get_current_pane()
    if current_pane_id == self.claude_pane.pane_id then
        self:_show()
    elseif current_pane_id == self.nvim_pane.pane_id then
        self:_hide()
    end
end

function M:get_active_bufnr()
    -- Return terminal buffer number or nil

    -- make sure that we don't return garbage
    return nil
end

function M:is_available()
    -- Return true if provider can be used
    if wezterm == nil then
        wezterm = require('wezterm')
    end
    return wezterm ~= nil
end

return M
