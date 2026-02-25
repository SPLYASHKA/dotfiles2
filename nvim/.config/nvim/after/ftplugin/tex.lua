local keymap = vim.keymap

keymap.set({ 'n' }, '<leader>p',
  "<cmd>TeXpresso %<cr>",
  { buffer = true, desc = "TeXpresso this file" }
)
