---@diagnostic disable: undefined-global

-- local function in_mathzone()
--   return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1
-- end

local ls = require("luasnip")
local tex = require("plugins._config.luasnip.tex")

-- NOTE: мб вынести эти функции в отдельный файлик ну и потом require (в tex тот же)
-- UPD: либо просто snip_env
local s_textonly = ls.extend_decorator.apply(s, {}, { condition = tex.in_text })
local parse_textonly = ls.extend_decorator.apply(parse, { condition = tex.in_text })
local snippets = {
}
local text_auto = {
  s("mk", fmt("${}$", { i(1, "inline_math") }), { condition = tex.in_text }),
  parse_textonly({ trig = "dm" }, "$$\n$1\n$$")
}

local s_mathonly = ls.extend_decorator.apply(s, {}, { condition = tex.math_mode, show_condition = tex.math_mode })
local parse_mathonly = ls.extend_decorator.apply(parse, { condition = tex.math_mode, show_condition = tex.math_mode })
local math_auto = {
}

-- NOTE: maybe turn in loop like envs
local greek = ls.extend_decorator.apply(parse_mathonly, { wordTrig = false, hidden = true })
local greek = {
  greek("@a", "\\alpha"),
  greek("@b", "\\beta"),
  greek("@g", "\\gamma"),
  greek("@G", "\\Gamma"),
  greek("@d", "\\delta"),
  greek("@D", "\\Delta"),
  greek("@e", "\\epsilon"),
  greek(":e", "\\varepsilon"),
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
  parse_mathonly({ trig = "invs", wordTrig = false }, "^{-1}"),
  parse_mathonly({ trig = "rd", wordTrig = false }, "^{$1}"),
  parse_mathonly({ trig = "_", wordTrig = false }, "_{$1}"),
  parse_mathonly({ trig = "sts", wordTrig = false }, "_\\text{$1}"),
  parse_mathonly("sq", "\\sqrt{$1}"),
  parse_mathonly("ee", "e^{$1}"),
}
vim.list_extend(math_auto, basic_operations)

local fractions = {
  s_mathonly(
    {
      trig = "([^%s=/]+)/",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 500,
      desc = "Auto fractions",
    },
    fmta(
      "\\frac{<>}{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
      }
    )
  ),
  -- TODO: сейчас работает только для не вложенных скобок, добавить пару уровней
  -- вложенности (бесконечность не получится, не регулярный язык)
  s_mathonly(
    {
      trig = [[(\([^()]\+\))/]],
      wordTrig = false,
      regTrig = true,
      trigEngine = "vim",
      priority = 1000, -- default value
      desc = "Auto fractions with parentheses",
    },
    fmta(
      "\\frac{<>}{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
      }
    )
  ),
  parse_mathonly({ trig = "//", wordTrig = false }, "\\frac{$1}{$2}"),
}
vim.list_extend(math_auto, fractions)

local smth = {
  parse_mathonly({ trig = "text", wordTrig = false }, "\\text{$1}"),
}
vim.list_extend(math_auto, smth)

local auto_number_subscript = {
  s_mathonly(
    {
      trig = "(%a)(%d)",
      wordTrig = false,
      regTrig = true,
      desc = "Auto letter number subscript"
    },
    f(function(_, snip)
      return snip.captures[1] .. "_" .. snip.captures[2]
    end, {})
  ),
  s_mathonly(
    {
      trig = "(%a)_(%d%d)",
      wordTrig = false,
      regTrig = true,
      desc = "More auto letter number subscript"
    },
    f(function(_, snip)
      return snip.captures[1] .. "_{" .. snip.captures[2] .. "}"
    end, {})
  ),
}
vim.list_extend(math_auto, auto_number_subscript)

-- Auto add slash and space
-- NOTE: mb split on two separate lists
local cmds = {
  "exp",
  "log",
  "ln",
  "det",
  "quad",
  "cos",
  "sin",
  "geq",
  "leq",
}
for _, cmd in pairs(cmds) do
  local snips = {
    s_mathonly(
      {
        trig = [[\v(^|[^\\])]] .. cmd,
        wordTrig = false,
        regTrig = true,
        trigEngine = "vim",
        desc = "Auto add slash"
      },
      {
        f(function(_, snip)
          return snip.captures[1]
        end, {}),
        t("\\" .. cmd)
      }
    ),
    s_mathonly(
      {
        trig = [[\\]] .. cmd .. [[\([A-Za-z0-9]\)]],
        wordTrig = false,
        regTrig = true,
        trigEngine = "vim",
        desc = "Auto add space"
      },
      {
        t("\\" .. cmd .. " "),
        f(function(_, snip)
          return snip.captures[1]
        end, {})
      }
    ),
  }
  vim.list_extend(math_auto, snips)
end

local symbol_accent = {
  parse_mathonly("hat", "\\hat{$1}"),
  postfix("hat", {
    l("\\hat{" .. l.POSTFIX_MATCH .. "}"),
  }, { condition = tex.math_mode }),
  parse_mathonly("bar", "\\bar{$1}"),
  parse_mathonly("dot", "\\dot{$1}"),
  parse_mathonly("ddot", "\\ddot{$1}"),
  parse_mathonly("tilde", "\\tilde{$1}"),
  parse_mathonly("und", "\\underline{$1}"),
  parse_mathonly("vec", "\\vec{$1}"),
}
vim.list_extend(math_auto, symbol_accent)

local derivatives = {
  parse_mathonly("par ", "\\frac{ \\partial ${1:y} }{ \\partial ${2:x} }"),
  parse_mathonly("ddt", "\\frac{\\mathrm{d}}{\\mathrm{d}t}"),
  parse_mathonly("dd ", "\\frac{ \\mathrm{d} ${1:y} }{ \\mathrm{d} ${2:x} }"),
}
vim.list_extend(math_auto, derivatives)

return snippets, vim.list_extend(text_auto, math_auto)
