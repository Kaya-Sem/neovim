return {
    "catppuccin/nvim",
    priority = 1000,
    init = function()
        -- set colorscheme based on the time of day
        local function set_colorscheme()
            local hour = tonumber(os.date("%H"))
            if hour >= 18 or hour < 6 then
                vim.cmd.colorscheme 'catppuccin-mocha'
            else
                vim.cmd.colorscheme 'catppuccin-latte'
            end
        end

        set_colorscheme()

        require("which-key").add({
            {
                "<leader>ul",
                ':colorscheme catppuccin-latte<CR>',
                desc = "[L]ightmode",
                mode = "n"
            },
            {
                "<leader>ud",
                ':colorscheme catppuccin-mocha<CR>',
                desc = "[D]arkmode",
                mode = "n"
            },
        })
    end,
}
