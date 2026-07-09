local M = {}

local has_treesitter, ts = pcall(require, 'vim.treesitter')
local _, query = pcall(require, 'vim.treesitter.query')

local MATH_NODES = {
  displayed_equation = true,
  inline_formula = true,
  math_environment = true,
}

local COMMENT = {
  ['comment'] = true,
  ['line_comment'] = true,
  ['block_comment'] = true,
  ['comment_environment'] = true,
}

function M.in_comment()
  if has_treesitter then
    local node = get_node_at_cursor()
    while node do
      if COMMENT[node:type()] then
        return true
      end
      node = node:parent()
    end
    return false
  end
end

function M.in_mathzone()
  if has_treesitter then
    -- local ts_utils = require("nvim-treesitter.ts_utils")
    -- local node = ts_utils.get_node_at_cursor()
    local node = vim.treesitter.get_node({ ignore_injections = false })
    while node do
      if node:type() == 'text_mode' then
        return false
      elseif MATH_NODES[node:type()] then
        return true
      end
      node = node:parent()
    end
    return false
  end
end

return M
