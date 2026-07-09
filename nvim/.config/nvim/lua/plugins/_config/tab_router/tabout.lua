local M = {}

function M.get(dir)
  local node_mod = require('tabout.node')
  local direction = dir == -1 and 'backward' or 'forward'
  local node = node_mod.get_node_at_cursor(direction)
  if node and node:parent() then
    local line, col = node_mod.get_tabout_position(node, direction, true)
    if line then
      return {
        row = line + 1,
        col = col
      }
    end
  end
end

function M.jump(dir)
  local plug = dir == -1 and "<Plug>(TaboutBackMulti)" or "<Plug>(TaboutMulti)"
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(plug, true, false, true), "m", true)
end

return M
