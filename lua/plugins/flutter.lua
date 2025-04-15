return {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,

    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    config = function()
        local tel = require("telescope")
        tel.load_extension("flutter")

        -- Set up which-key for flutter commands
        require("which-key").add({
            { "<leader>fc", tel.extensions.flutter.commands, desc = "Search flutter commands" },
            {
                "<leader>fr",
                function()
                    vim.cmd("term flutter run") -- Executes flutter run in a terminal
                end,
                desc = "Run flutter app"
            }
        })
    end,
}
