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

-- automatically autodelim csv files
vim.cmd([[
  augroup CSVAutoCommand
    autocmd!
    autocmd BufEnter *.csv lua JumpToFirstDelimiterAndRainbow()
  augroup END
]])

function JumpToFirstDelimiterAndRainbow()
  -- Store the initial cursor position
  local initial_pos = vim.fn.getpos('.')

  -- Search for the first occurrence of ',' or ';'
  vim.fn.search('[,;]', 'W')

  -- Execute the RainbowDelim command
  vim.cmd('RainbowDelim')

  -- Reset cursor to the first character of the first line
  vim.cmd('normal! gg0')

  -- Restore the initial cursor position
  vim.fn.setpos('.', initial_pos)
end
