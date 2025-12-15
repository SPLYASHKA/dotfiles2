---@diagnostic disable: undefined-global

local ls = require("luasnip")

-- TODO: можно в целом убрать этот виртуальный ft
ls.filetype_extend("tex", { "latexmath" })

local tex = require("plugins._config.luasnip.tex.conditions")

return {}, {}
