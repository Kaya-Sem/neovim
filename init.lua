vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.o.conceallevel = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'nosplit' -- substitution live preview [split, "", nosplit]
vim.opt.hlsearch = true
vim.opt.scrolloff = 2

vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.opt_local.textwidth = 300
vim.opt_local.wrap = true
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.opt.swapfile = false

-- stop vimtex from opening warning windows all the time
vim.g.vimtex_quickfix_mode = 0

vim.opt.laststatus = 3 -- Only show 1 status-line regardless of window-count


vim.o.hidden = true
vim.keymap.set('n', 'H', ':bprev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'L', ':bnext<CR>', { noremap = true, silent = true })


require('keymaps')
require('autocommands')


local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  ui = {
    border = "rounded",
  },

  {
    import = 'plugins'
  },
}
)
