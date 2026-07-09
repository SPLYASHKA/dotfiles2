local M = {}

local _tabout = require("plugins._config.tab_router.tabout")
local neotab = require("plugins._config.tab_router.neotab")
local luasnip = require("plugins._config.tab_router.luasnip")

local neotab_filetypes = { "markdown" }
M.neotab_filetypes = neotab_filetypes

local function before(a, b)
  if a.row ~= b.row then
    return a.row < b.row
  end

  return a.col < b.col
end

function M.handle(dir)
  local tabout = _tabout
  if vim.list_contains(neotab_filetypes, vim.bo.filetype)
      or not vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] then
    tabout = neotab
  end

  local tabout_pos = tabout.get(dir)
  local luasnip_pos = luasnip.get(dir)

  if not tabout_pos then
    return false
  end

  if not luasnip_pos then
    tabout.jump(dir)
    return true
  end

  if dir == -1 and before(luasnip_pos, tabout_pos) then
    tabout.jump(-1)
    return true
  elseif dir == 1 and before(tabout_pos, luasnip_pos) then
    tabout.jump(1)
    return true
  end

  return false
end

return M
