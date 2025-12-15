---@diagnostic disable: undefined-global

-- local function in_mathzone()
--   return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1
-- end

local ls = require("luasnip")
local tex = require("plugins._config.luasnip.tex")

local s_textonly = ls.extend_decorator.apply(s, {}, { condition = tex.in_text })
local parse_textonly = ls.extend_decorator.apply(parse, { condition = tex.in_text })
local snippets = {
}
local text_auto = {
}

local s_mathonly = ls.extend_decorator.apply(s, {}, { condition = tex.math_mode, show_condition = tex.math_mode })
-- NOTE: luasnip currently have a bug with parse extend,
-- check this PL: https://github.com/L3MON4D3/LuaSnip/pull/1403
-- this snippets doesnt work with luasnip yet (I use my fork)
local parse_mathonly = ls.extend_decorator.apply(parse, { condition = tex.math_mode, show_condition = tex.math_mode })
local math_auto = {
}

-- TODO: add gather* toggle via choice node
-- Enviroments
local envs = {
  gat = "gather",
  align = "align",
  multiline = "multiline",
}
for trigger, env in pairs(envs) do
  -- local snip = parse_textonly(trigger, string.format("\\begin{%s}\n$1\n\\end{%s}\n$0", env, env))
  local snip = parse_textonly(trigger, string.format("\\begin{%s}\n$1\n\\end{%s}$0", env, env))
  table.insert(text_auto, snip)
end
-- Math enviroments
local envs = {
  gat = "gathered",
  align = "aligned",
  split = "split",
  array = "array",
}
for trigger, env in pairs(envs) do
  -- local snip = parse_mathonly(trigger, string.format("\\begin{%s}\n$1\n\\end{%s}\n$0", env, env))
  local snip = parse_mathonly(trigger, string.format("\\begin{%s}\n$1\n\\end{%s}$0", env, env))
  table.insert(math_auto, snip)
end

-- NOTE: мб разделить tex.in_matrix и tex.in_multiline на два разных сниппета,
-- но вроде норм
local s_helper = ls.extend_decorator.apply(s, { wordTrig = false, hidden = true },
  {
    condition = (tex.in_matrix + tex.in_multiline) * conds.line_end * conds.trigger_not_preceded_by(" ") -
        conds.line_begin
  })
local matrix = {
  pmat = "pmatrix",
  bmat = "bmatrix",
  Bmat = "Bmatrix",
  vmat = "vmatrix",
  Vmat = "Vmatrix",
  matrix = "matrix",
}
local matrices = {
  -- only if part of the word. " n" doesnt trigger snippet,
  -- and only in end of the line
  s_helper("n", t(" & ")),
  s_helper("m", t({ " \\\\ ", "" })),
}
-- TODO: сделать чтобы если я начинал печатать после окружения, то переносилось
-- на новую строку, что-то типо env, c(""|"\n"), i(1), условный перенос строки
-- сделать видимо через функцию, либо чекнуть luasnip docs на проверку empty
-- UPD: это плохо, 1 грустно но no_empty не может возвращать new_line,
-- 2. будет постоянно расти стек сниппетов, потому что таким образом мы не
-- выйдем из текущего снипета
for trigger, env in pairs(matrix) do
  -- local snip = parse_mathonly(trigger, "\\begin{" .. env .. "}\n$1\n\\end{" .. env .. "}\n$0")
  local snip = parse_mathonly(trigger, string.format("\\begin{%s}\n$1\n\\end{%s}$0", env, env))
  table.insert(matrices, snip)
end
vim.list_extend(math_auto, matrices)

return snippets, vim.list_extend(text_auto, math_auto)
