-- NOTE: короче есть вайбик переписать это чудо
-- мне нравится как тут работает все,
-- но я бы хотел переписать через ratex вместо mitex,
-- и render через vim.ui.image, но нужно подождать наверное
-- когда vim.ui.image станет более менее стабильным
-- можно будет сделать фичу для latex, как здесь для typst,
-- с подсветкой текущего положения курсора в live preview
-- также я так понимаю здесь поддерживается только markdown,
-- а не latex, можно добавить соответсвенно поддерждку
return {
  enabled = true,
  "pxwg/math-conceal.nvim",
  branch = "preview",
  build = "cargo build --release --manifest-path service/Cargo.toml",
  main = "math-conceal",
  opts = {
    conceal = {
      "greek",
      "script",
      "math",
      "font",
      "delim",
      "phy",
    },
    ft = { "plaintex", "tex", "context", "bibtex", "markdown", "typst" },
    image = {
      enabled = true,
      filetypes = { "typst", "markdown", "tex" },
    },
  },
}
