-- disable relative lines in command mode
vim.api.nvim_create_autocmd({ "CmdlineEnter", "WinLeave" }, {
  group = vim.api.nvim_create_augroup("cmd-line-relnum-toggle-on", { clear = true }),
  callback = function()
    vim.wo.relativenumber = false
    vim.cmd([[ redraw ]])
  end,
})

-- enable relative numbers in normal mode
vim.api.nvim_create_autocmd({ "CmdlineLeave", "WinEnter" }, {
  group = vim.api.nvim_create_augroup("cmd-line-relnum-toggle-off", { clear = true }),
  callback = function()
    vim.wo.relativenumber = true
    vim.cmd([[ redraw ]])
  end,
})

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Set wrap width for Markdown files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.textwidth = 65
    vim.opt_local.wrap = true
  end,
})
