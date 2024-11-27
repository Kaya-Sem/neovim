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
      { "<leader>oo",   ':ObsidianOpen<CR>',        desc = "[O]pen in Obsidian", mode = "n" },
      { "<leader>os",   ':ObsidianSearch<CR>',      desc = "[S]earch Obsidian",  mode = "n" },
      { "<leader>oqs",  ':ObsidianQuickSwitch<CR>', desc = "[Q]uickswitch",      mode = "n" },
      { "<leader><CR>", ':ObsidianFollowLink<CR>',  desc = "[E]nter Link",       mode = "n" },
      { "<leader>ot",   ':ObsidianTOC<CR>',         desc = "[T]OC",              mode = "n" },
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
