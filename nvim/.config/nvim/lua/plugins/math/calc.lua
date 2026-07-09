return {
  "splyashka/calc.nvim",
  enabled = true,
  build = ":UpdateRemotePlugins",
  init = function()
    vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin") .. "/python3"
  end,
  keys = {
    {
      '<leader>cl',
      ":CalcPushLatexVisual<CR>",
      desc = 'Calc push latex visual selection',
      mode = { "x" },
    },
  }
}
