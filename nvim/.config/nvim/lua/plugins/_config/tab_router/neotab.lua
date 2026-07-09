local M = {}

function M.get()
  local tab = require("neotab.tab")

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local pos = vim.api.nvim_win_get_cursor(0) -- { row=1, col=0 }
  local md = tab.out(lines, pos)

  if not md then
    return nil
  end

  return {
    row = pos[1],     -- строка не меняется (tabout ищет только в текущей строке)
    col = md.pos - 1, -- md.pos 1-based → neovim 0-based
  }
end

function M.jump()
  require("neotab").tabout()
end

function M.jump()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>(neotab-out)", true, false, true), "m", true)
end

return M
