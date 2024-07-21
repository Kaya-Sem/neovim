return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  init = function()
    require("which-key").add({
      { "<leader>oo", ':ObsidianOpen<CR>', desc = "[O]pen in Obsidian", mode = "n" }
    })
  end,

  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Data",
      },
    },
  },
}
