return {
    "leath-dub/snipe.nvim",
    keys = {
        { "gs", function() require("snipe").open_buffer_menu() end, desc = "Open Snipe buffer menu" }
    },
    opts = {

        ui = {
            position = "cursor"
        }
    }
}
