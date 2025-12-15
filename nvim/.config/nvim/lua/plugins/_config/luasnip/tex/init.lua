local tex = require("plugins._config.luasnip.tex.conditions")
local cond = require("luasnip.extras.conditions")

local M = {}

M.math_mode = cond.make_condition(tex.math_mode)
M.in_matrix = cond.make_condition(tex.in_matrix)
M.in_multiline = cond.make_condition(tex.in_multiline)
M.in_text = cond.make_condition(tex.in_text)
return M
