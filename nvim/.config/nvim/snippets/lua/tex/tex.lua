local ls = require("luasnip")

ls.filetype_extend("tex", { "latexmath" })

local tex = require("plugins._config.luasnip.tex.conditions")

return {}, {}
