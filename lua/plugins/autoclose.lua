return {
    "m4xshen/autoclose.nvim",
    config = function()
        require("autoclose").setup({
            options = {
                disable_when_touch = true,
                pair_spaces = true,
            },
            keys = {
                ["/*"] = {
                    escape = true,
                    close = true,
                    pair = "/* */",
                    enabled_filetypes = {
                        "c", "cpp", "h",
                    }
                },
            }
        })
    end,
}
