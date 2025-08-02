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
      { "<leader>o",     group = "Obsidian" },
      { "<leader>o<CR>", "<cmd>ObsidianFollowLink<CR>",  desc = "[E]nter Link" },
      { "<leader>oo",    "<cmd>ObsidianOpen<CR>",        desc = "[O]pen in Obsidian" },
      { "<leader>oqs",   "<cmd>ObsidianQuickSwitch<CR>", desc = "[Q]uickswitch" },
      { "<leader>os",    "<cmd>ObsidianSearch<CR>",      desc = "[S]earch Obsidian" },
      { "<leader>ot",    "<cmd>ObsidianTOC<CR>",         desc = "[T]OC" },
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
