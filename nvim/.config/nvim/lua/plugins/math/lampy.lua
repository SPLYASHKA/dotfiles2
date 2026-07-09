local math_ft = { "markdown", "tex" }

return {
  "SPLYASHKA/lampy.nvim",
  build = ":UpdateRemotePlugins",
  keys = {
    { "<leader>le", ":LampyEval<CR>",            mode = "x", ft = math_ft, desc = "Lampy eval visual selection" },
    { "<leader>lE", ":LampyEvalReplace<CR>",     mode = "x", ft = math_ft, desc = "Lampy eval replace" },
    { "<leader>lf", ":LampyFactor<CR>",          mode = "x", ft = math_ft, desc = "Lampy factor" },
    { "<leader>lx", ":LampyExpand<CR>",          mode = "x", ft = math_ft, desc = "Lampy expand" },
    { "<leader>ld", ":LampyDefineVar<CR>",       mode = "x", ft = math_ft, desc = "Lampy define variable" },
    { "<leader>ln", ":LampyNumerical<CR>",       mode = "x", ft = math_ft, desc = "Lampy numerical" },
    { "<leader>lp", ":LampyPython<CR>",          mode = "x", ft = math_ft, desc = "Lampy python" },
    { "<leader>le", ":LampyEvalLine<CR>",        ft = math_ft, desc = "Lampy eval line" },
    { "<leader>lE", ":LampyEvalReplaceLine<CR>", ft = math_ft, desc = "Lampy eval replace line" },
    { "<leader>lf", ":LampyFactorLine<CR>",      ft = math_ft, desc = "Lampy factor line" },
    { "<leader>lx", ":LampyExpandLine<CR>",      ft = math_ft, desc = "Lampy expand line" },
    { "<leader>ld", ":LampyDefineVarLine<CR>",   ft = math_ft, desc = "Lampy define variable line" },
    { "<leader>ln", ":LampyNumericalLine<CR>",   ft = math_ft, desc = "Lampy numerical line" },
    { "<leader>lp", ":LampyPythonLine<CR>",      ft = math_ft, desc = "Lampy python line" },
    { "<leader>ls", ":LampyShowVars<CR>",        ft = math_ft, desc = "Lampy show variables" },
    { "<leader>lR", ":LampyResetVars<CR>",       ft = math_ft, desc = "Lampy reset variables" },
  },
}
