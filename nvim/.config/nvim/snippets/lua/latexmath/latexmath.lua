---@diagnostic disable: undefined-global

-- local function in_mathzone()
--   return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1
-- end

local ls = require("luasnip")
local tex = require("plugins._config.luasnip.tex.conditions")

tex.in_text = function()
  return not tex.math_mode()
end

local s_textonly = ls.extend_decorator.apply(s, {}, { condition = tex.in_text })
local parse_textonly = ls.extend_decorator.apply(parse, { condition = tex.in_text })
local text_auto = {
  s("mk", fmt("${}$", { i(1, "inline_math") }), { condition = tex.in_text }),
  parse_textonly({ trig = "dm" }, "$$\n$0\n$$")
}

local s_mathonly = ls.extend_decorator.apply(s, {}, { condition = tex.math_mode, show_condition = tex.math_mode })
-- NOTE: luasnip currently have a bug with parse extend,
-- check this PL: https://github.com/L3MON4D3/LuaSnip/pull/1403
-- this snippets doesnt work with luasnip yet (I use my fork)
local parse_mathonly = ls.extend_decorator.apply(parse, { condition = tex.math_mode, show_condition = tex.math_mode })
local math_auto = {
  s("inmath", { t("yuuuuuupoooo!!!!") }, { condition = tex.math_mode }),
  -- ls.parser.parse_snippet("yoy", "buga $TM_FILENAME fr ${1:boy} bebe"),
  parse({ trig = "yoy", condition = tex.in_text }, "buga $TM_FILENAME fr ${1:boy} bebe"),
  s_mathonly("gol", fmt("bebbebebe", {})),
}

local greek = ls.extend_decorator.apply(parse_mathonly, { wordTrig = false, hidden = true })
local greek = {
  greek("@a", "\\alpha"),
  greek("@b", "\\beta"),
  greek("@g", "\\gamma"),
  greek("@G", "\\Gamma"),
  greek("@d", "\\delta"),
  greek("@D", "\\Delta"),
  greek("@e", "\\epsilin"),
  greek(":e", "\\varepsilin"),
  greek("@z", "\\zeta"),
  greek("@t", "\\theta"),
  greek("@T", "\\Theta"),
  greek(":t", "\\vartheta"),
  greek("@i", "\\iota"),
  greek("@k", "\\kappa"),
  greek("@l", "\\lambda"),
  greek("@L", "\\Lambda"),
  greek("@s", "\\sigma"),
  greek("@S", "\\Sigma"),
  greek("@u", "\\upsilon"),
  greek("@U", "\\Upsilon"),
  greek("@o", "\\omega"),
  greek("@O", "\\Omega"),
  greek("ome", "\\omega"),
  greek("Ome", "\\Omega"),
  greek("@p", "\\phi"),
  greek("@P", "\\Phi"),
  greek(":p", "\\varphi"),
  greek(":P", "\\varPhi"),
}
vim.list_extend(math_auto, greek)

local basic_operations = {
  parse_mathonly({ trig = "sr", wordTrig = false }, "^{2}"),
  parse_mathonly({ trig = "cb", wordTrig = false }, "^{3}"),
  parse_mathonly({ trig = "rd", wordTrig = false }, "^{$1}"),
  parse_mathonly({ trig = "_", wordTrig = false }, "_{$1}"),
  parse_mathonly({ trig = "sts", wordTrig = false }, "_\\text{$1}"),
  parse_mathonly("sq", "\\sqrt{$1}"),
  parse_mathonly("ee", "e^{$1}"),
}
vim.list_extend(math_auto, basic_operations)

local symbol_accent = {
  parse_mathonly("hat", "\\hat{$1}"),
  parse_mathonly("bar", "\\bar{$1}"),
  parse_mathonly("dot", "\\dot{$1}"),
  parse_mathonly("ddot", "\\ddot{$1}"),
  parse_mathonly("tilde", "\\tilde{$1}"),
  parse_mathonly("und", "\\underline{$1}"),
  parse_mathonly("vec", "\\vec{$1}"),
}
vim.list_extend(math_auto, symbol_accent)

return {}, vim.list_extend(text_auto, math_auto)
