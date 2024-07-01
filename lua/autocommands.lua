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
