return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  init = function()
    require("which-key").register({
      o = {
        name = "Obsidian",
        o = { "<cmd>ObsidianOpen<CR>", "[O]pen in Obsidian" },
        s = { "<cmd>ObsidianSearch<CR>", "[S]earch Obsidian" },
        q = {
          s = { "<cmd>ObsidianQuickSwitch<CR>", "[Q]uickswitch" },
        },
        t = { "<cmd>ObsidianTOC<CR>", "[T]OC" },
        ["<CR>"] = { "<cmd>ObsidianFollowLink<CR>", "[E]nter Link" },
      },
    }, { prefix = "<leader>" })
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
