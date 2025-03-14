return {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,

    dependencies = {
        "nvim-lua/plenary.nvim",
    },


    config = function()
        local tel = require("telescope")
        tel.load_extension("flutter")

        require("which-key").add({
            { "<leader>fc", tel.extensions.flutter.commands, desc = "Search flutter commands" }


        })
    end,
}
