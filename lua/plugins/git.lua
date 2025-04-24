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
    keys = {
      { "<leader>gl", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    },
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").register({
        g = {
          name = "Git",
          l = { "<cmd>LazyGit<cr>", "LazyGit" },
          h = {
            name = "Hunk",
            s = { function() require('gitsigns').stage_hunk() end, "Stage hunk" },
            r = { function() require('gitsigns').reset_hunk() end, "Reset hunk" },
            S = { function() require('gitsigns').stage_buffer() end, "Stage buffer" },
            u = { function() require('gitsigns').undo_stage_hunk() end, "Undo stage hunk" },
            R = { function() require('gitsigns').reset_buffer() end, "Reset buffer" },
            p = { function() require('gitsigns').preview_hunk() end, "Preview hunk" },
            b = { function() require('gitsigns').blame_line() end, "Blame line" },
            d = { function() require('gitsigns').diffthis() end, "Diff against index" },
            D = { function() require('gitsigns').diffthis('@') end, "Diff against last commit" },
          },
          t = {
            name = "Toggle",
            b = { function() require('gitsigns').toggle_current_line_blame() end, "Toggle blame line" },
            D = { function() require('gitsigns').toggle_deleted() end, "Toggle show deleted" },
          },
        },
      }, { prefix = "<leader>" })

      -- Visual mode mappings
      require("which-key").register({
        g = {
          h = {
            name = "Hunk",
            s = { function() require('gitsigns').stage_hunk({vim.fn.line('.'), vim.fn.line('v')}) end, "Stage hunk" },
            r = { function() require('gitsigns').reset_hunk({vim.fn.line('.'), vim.fn.line('v')}) end, "Reset hunk" },
          },
        },
      }, { prefix = "<leader>", mode = "v" })
    end,
  },
} 