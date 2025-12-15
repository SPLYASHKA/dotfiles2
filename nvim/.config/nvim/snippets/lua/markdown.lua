---@diagnostic disable: undefined-global

local ls = require("luasnip")

-- ls.filetype_extend("markdown", { "latexmath" })

-- https://github.com/L3MON4D3/LuaSnip/issues/823
ls.filetype_extend("markdown_inline", { "markdown" })

local tex = require("plugins._config.luasnip.tex")
local parse_textonly = ls.extend_decorator.apply(parse, { condition = tex.in_text })
local text_auto = {
  s("mk", fmt("${}$", { i(1, "inline_math") }), { condition = tex.in_text }),
  parse_textonly({ trig = "dm" }, "$$\n$1\n$$")
}

return {}, text_auto
