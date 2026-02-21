vim.api.nvim_create_user_command("Pinright", function(opts)
  opts = opts or {}
  local line1 = opts.line1 or -1
  local line2 = opts.line2 or -1

  if line1 < 0 or line2 < 0 then
    print("Invalid range, aborting.")
    return
  end

  local source_win = vim.api.nvim_get_current_win()
  local source_buf = vim.api.nvim_get_current_buf()

  local lines = vim.api.nvim_buf_get_lines(source_buf, line1 - 1, line2, false)

  local source_ft = vim.bo[source_buf].filetype

  vim.cmd("vsplit")
  local new_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, new_buf)

  vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, lines)

  vim.bo[new_buf].buftype = "nofile"
  vim.bo[new_buf].bufhidden = "wipe"
  vim.bo[new_buf].swapfile = false
  vim.bo[new_buf].filetype = source_ft

  vim.api.nvim_set_current_win(source_win)
end, { range = true })


vim.api.nvim_create_user_command("Pintop", function(opts)
  opts = opts or {}
  local line1 = opts.line1 or -1
  local line2 = opts.line2 or -1

  if line1 < 0 or line2 < 0 then
    print("Invalid range, aborting.")
    return
  end

  vim.cmd("topleft split")
  vim.opt_local.scrolloff = 0
  vim.cmd.resize(line2 - line1 + 1)
  vim.cmd("normal! " .. line2 .. "G")
  vim.cmd.wincmd('j')
end, { range = true })


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

local function discord(line1, line2)
  local extension = vim.bo.filetype
  local reg_save = vim.fn.getreg('"')
  local lines = vim.api.nvim_buf_get_lines(0, line1 - 1, line2, false)
  lines = gobble(lines)
  local selected_text = table.concat(lines, "\n")
  local code_block = "```" .. extension .. "\n" .. selected_text .. "\n```\n"
  vim.fn.setreg("+", code_block)
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
  discord(line1, line2)
end, { range = true })
