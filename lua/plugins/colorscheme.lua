return {
    "catppuccin/nvim",
    priority = 1000,
    init = function()
        -- Extract TokyoNight themes to variables
        local light_theme = 'catppuccin-latte'
        local dark_theme = 'catppuccin-mocha'

        -- Set colorscheme based on the time of day
        local function set_colorscheme()
            local hour = tonumber(os.date("%H"))
            if hour >= 15 or hour < 6 then
                vim.cmd.colorscheme(dark_theme)
            else
                vim.cmd.colorscheme(light_theme)
            end
        end

        set_colorscheme()

        -- Set up which-key bindings using the themes
        require("which-key").add({
            {
                "<leader>ul",
                ':colorscheme ' .. light_theme .. '<CR>',
                desc = "[L]ightmode",
                mode = "n"
            },
            {
                "<leader>ud",
                ':colorscheme ' .. dark_theme .. '<CR>',
                desc = "[D]arkmode",
                mode = "n"
            },
        })
    end,
}
