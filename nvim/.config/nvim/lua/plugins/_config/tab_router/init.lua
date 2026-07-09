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

-- NOTE: была идея использовать ближайший прыжок из всех провайдеров,
-- может быть потом буду использовать, но сейчас достаточно использовать
-- стратегию: neotab -> luasnip, при этом (|xxxx) neotab игнорирует
-- UPD: все же оставлю свое, чтобы можно было еще и tabout.nvim использовать
-- хотя прекрасно можно было бы нижний вариант брать
-- NOTE: вообще надо бы еще разобраться с <S-Tab>, но щас супер в падлу
function M.handle()
  local tabout = _tabout
  if vim.list_contains(neotab_filetypes, vim.bo.filetype)
      or not vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] then
    tabout = neotab
  end

  local tabout_pos = tabout.get()
  local luasnip_pos = luasnip.get()

  if not tabout_pos then
    return false
  end

  if not luasnip_pos then
    tabout.jump()
    return true
  end

  if before(tabout_pos, luasnip_pos) then
    tabout.jump()
    return true
  end

  return false
end

-- Здесь буквально эта стратегия используется
-- function M.handle()
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>(neotab-out-luasnip)", true, false, true), "m", true)
--   return true
-- end

return M
