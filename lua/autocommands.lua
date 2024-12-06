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

local view_group = vim.api.nvim_create_augroup("auto_view", { clear = true })

-- Save view with mkview for real files
vim.api.nvim_create_autocmd({ "BufWinLeave", "BufWritePost", "WinLeave" }, {
  desc = "Save view with mkview for real files",
  group = view_group,
  callback = function(args)
    if vim.b[args.buf].view_activated then
      pcall(vim.cmd, "mkview!")
    end
  end,
})

-- Load view if available and enable view saving for real files
vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Try to load file view if available and enable view saving for real files",
  group = view_group,
  callback = function(args)
    if not vim.b[args.buf].view_activated then
      local filetype = vim.bo[args.buf].filetype
      local buftype = vim.bo[args.buf].buftype
      local ignore_filetypes = { "gitcommit", "gitrebase", "svg", "hgcommit" }

      if buftype == "" and filetype ~= "" and not vim.tbl_contains(ignore_filetypes, filetype) then
        vim.b[args.buf].view_activated = true
        pcall(vim.cmd, "silent! loadview")
      end
    end
  end,
})
