return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.diagnostic.config({
      virtual_text = true,
      -- virtual_lines = true,
      signs = true,      -- отображение в gutter (столбце слева)
      underline = true,  -- подчёркивание проблем
      update_in_insert = false,  -- не показывать при наборе
    })
    vim.lsp.enable("clangd")
  end,
}
