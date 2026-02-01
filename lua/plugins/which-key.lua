-- Show user-defined commands in a scratch buffer (script_id ~= 0 means user/script-defined)
local function show_user_commands()
    local all = vim.api.nvim_get_commands({})
    local user = {}
    for name, info in pairs(all) do
        if info.script_id and info.script_id ~= 0 then
            user[name] = info
        end
    end

    local lines = { "# User-defined commands", "" }
    local names = vim.tbl_keys(user)
    table.sort(names)
    for _, name in ipairs(names) do
        local desc = user[name].desc
        table.insert(lines, ("- `:%s`%s"):format(name, desc and (" — " .. desc) or ""))
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
    vim.cmd("vsplit")
    vim.api.nvim_win_set_buf(0, buf)
end

return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
        {
            "<leader>uc",
            show_user_commands,
            desc = "List user-defined [C]ommands",
        },
        { "<leader>f", group = "LSP" },
    },
}
