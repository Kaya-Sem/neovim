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

vim.api.nvim_create_user_command("Pintop", function(opts)
  opts = opts or {}
  local line1 = opts.line1 or -1
  local line2 = opts.line2 or -1

  if line1 < 0 or line2 < 0 then
    print("Invalid range, aborting.")
    return
  end

  -- Split current buffer, and make top buffer only show the selection
  --  vim.cmd.split()
  vim.cmd("topleft split")
  vim.opt_local.scrolloff = 0
  vim.cmd.resize(line2 - line1 + 1)
  vim.cmd("normal! " .. line2 .. "G")
  vim.cmd.wincmd('j')
end, { range = true })


-- discord from bwindey or something
--
local function gobble(lines)
  -- Taken from "michealrommel/nvim-silicon/lua/nvim-silicon/utils.lua"
  local shortest_whitespace = nil
  local whitespace = ""
  for _, v in pairs(lines) do
    _, _, whitespace = string.find(v, "^(%s*)")
    if type(whitespace) ~= "nil" then
      if shortest_whitespace == nil
          or (#whitespace < #shortest_whitespace and v ~= "") then
        shortest_whitespace = whitespace
      end
    end
  end

  if #shortest_whitespace > 0 then
    local newlines = {}
    for _, v in pairs(lines) do
      local newline = string.gsub(v, "^" .. shortest_whitespace, "", 1)
      table.insert(newlines, newline)
    end
    return newlines
  else
    return lines
  end
end

function Discord(line1, line2)
  -- Get file extension based on buffer's filetype
  local extension = vim.bo.filetype

  -- Save current register contents
  local reg_save = vim.fn.getreg('"')

  -- Get selected lines, and remove common leading whitespace
  local lines = vim.api.nvim_buf_get_lines(0, line1 - 1, line2, false)
  lines = gobble(lines)
  local selected_text = table.concat(lines, "\n")

  -- Surround the text in a Markdown code-block
  local code_block = "```" .. extension .. "\n" .. selected_text .. "\n```\n"

  -- Copy code block to clipboard
  vim.fn.setreg("+", code_block)

  -- Restore original register contents
  vim.fn.setreg('"', reg_save)

  print("Copied to clipboard")
end

vim.api.nvim_create_user_command("Discord", function(opts)
  opts = opts or {}
  local line1 = opts.line1 or -1
  local line2 = opts.line2 or -1

  if line1 < 0 or line2 < 0 then
    print("Invalid range, aborting.")
    return
  end
  Discord(line1, line2)
end, { range = true })
