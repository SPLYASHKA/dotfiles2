local M = {}

function M.get(dir)
  local tab = require("neotab.tab")
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local pos = vim.api.nvim_win_get_cursor(0)
  local fn = dir == -1 and tab.reverse or tab.out
  local md = fn(lines, pos)
  if not md then return nil end
  return {
    row = pos[1],
    col = md.pos - 1,
  }
end

function M.jump(dir)
  local plug = dir == -1 and "<Plug>(neotab-reverse)" or "<Plug>(neotab-out)"
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(plug, true, false, true), "m", true)
end

return M
