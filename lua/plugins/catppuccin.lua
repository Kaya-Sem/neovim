return {
    "catppuccin/nvim",
    priority = 1000,
    init = function()
        vim.cmd.colorscheme 'catppuccin-latte'

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
