---@diagnostic disable: undefined-global

local ls = require("luasnip")
local tex = require("plugins._config.luasnip.tex")

-- NOTE: мб вынести эти функции в отдельный файлик ну и потом require (в tex тот же)
-- UPD: либо просто snip_env
local s_textonly = ls.extend_decorator.apply(s, {}, { condition = tex.in_text })
local parse_textonly = ls.extend_decorator.apply(parse, { condition = tex.in_text })
local snippets = {
}
local text_auto = {
}

local s_mathonly = ls.extend_decorator.apply(s, {}, { condition = tex.math_mode, show_condition = tex.math_mode })
local parse_mathonly = ls.extend_decorator.apply(parse, { condition = tex.math_mode, show_condition = tex.math_mode })
local math_auto = {
}

local operations = {
  ["==="] = "\\equiv",
  ["!="] = "\\neq",
  [">="] = "\\geq",
  ["<="] = "\\leq",
  [">>"] = "\\gg",
  ["<<"] = "\\ll",
  ["simm"] = "\\sim",
  ["sim="] = "\\simeq",
  ["prop"] = "\\propto",
}

for trigger, op in pairs(operations) do
  -- local snip = parse_mathonly(trigger, "\\begin{" .. env .. "}\n$1\n\\end{" .. env .. "}\n$0")
  local snip = parse_mathonly({ trig = trigger, wordTrig = false }, op)
  table.insert(math_auto, snip)
end
-- vim.list_extend(math_auto, matrices)

return snippets, vim.list_extend(text_auto, math_auto)
