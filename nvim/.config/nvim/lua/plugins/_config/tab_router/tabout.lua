local M = {}

function M.get()
  local before = vim.api.nvim_win_get_cursor(0)

  require("tabout").tabout()

  local after = vim.api.nvim_win_get_cursor(0)

  vim.api.nvim_win_set_cursor(0, before)

  if before[1] == after[1] and before[2] == after[2] then
    return nil
  end

  local pos = {
    row = after[1],
    col = after[2],
  }

  return pos
end

function M.get()
  local node_mod = require('tabout.node')

  local node = node_mod.get_node_at_cursor('forward')

  if node and node:parent() then
    local line, col = node_mod.get_tabout_position(node, 'forward', true)
    if line then
      return {
        row = line + 1, -- позиция: {line + 1, col}  (line из TS — 0-indexed)
        col = col
      }
    end
  end
end

function M.jump()
  require("tabout").tabout()
end

function M.jump()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>(TaboutMulti)", true, false, true), "m", true)
end

return M
