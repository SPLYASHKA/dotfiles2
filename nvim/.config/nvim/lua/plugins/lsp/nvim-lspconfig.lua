return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  -- TODO: может быть вынести это в core/lsp.lua
  config = function()
    vim.diagnostic.config({
      virtual_text = true,
      -- virtual_lines = true,
      float = { border = 'single' },
      signs = true,      -- отображение в gutter (столбце слева)
      underline = true,  -- подчёркивание проблем
      update_in_insert = false,  -- не показывать при наборе
    })

    local lsp_enabled = {
      "clangd",
      "lua_ls",
      "marksman",
      "asm_lsp",
    }
    vim.lsp.enable(lsp_enabled)
  end,
}
