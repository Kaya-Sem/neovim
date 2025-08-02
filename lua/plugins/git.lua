return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        on_attach = function(bufnr)
          local gitsigns = require 'gitsigns'

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal { ']c', bang = true }
            else
              gitsigns.nav_hunk 'next'
            end
          end, { desc = 'Jump to next git [c]hange' })

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal { '[c', bang = true }
            else
              gitsigns.nav_hunk 'prev'
            end
          end, { desc = 'Jump to previous git [c]hange' })
        end,
      }
    end
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },

  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").add({
        { "<leader>g",   group = "Git" },
        { "<leader>gh",  group = "Hunk" },
        --   { "<leader>gl",  function() Lazygit end,           desc = "Lazygit" },
        { "<leader>gb",  function() require('gitsigns').blame_line() end,                desc = "Blame line" },

        -- Git Toggle
        { "<leader>gt",  group = "Toggle" },
        { "<leader>gtD", function() require('gitsigns').toggle_deleted() end,            desc = "Toggle show deleted" },
        { "<leader>gtb", function() require('gitsigns').toggle_current_line_blame() end, desc = "Toggle blame line" },


        -- Git hunk
        { "<leader>ghS", function() require('gitsigns').stage_buffer() end,              desc = "Stage buffer" },
        { "<leader>ghu", function() require('gitsigns').undo_stage_hunk() end,           desc = "Undo stage hunk" },
        { "<leader>ghR", function() require('gitsigns').reset_buffer() end,              desc = "Reset buffer" },
        { "<leader>ghp", function() require('gitsigns').preview_hunk() end,              desc = "Preview hunk" },
        { "<leader>ghd", function() require('gitsigns').diffthis() end,                  desc = "Diff against index" },
        { "<leader>ghD", function() require('gitsigns').diffthis('@') end,               desc = "Diff against last commit" },


        {
          mode = { "v" },
          { "<leader>ghs", function() require('gitsigns').stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, desc = "Stage hunk" },

          { "<leader>ghr", function() require('gitsigns').reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, desc = "Reset hunk" }


        },

      })
    end,
  },
}
