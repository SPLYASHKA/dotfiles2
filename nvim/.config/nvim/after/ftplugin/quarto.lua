local keymap = vim.keymap

keymap.set({ 'n' }, '<leader>p',
  function() require('quarto').quartoPreview() end,
  { buffer = true, desc = "Open quatro preview" }
)

local runner = require("quarto.runner")
keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
keymap.set("n", "<localleader>RA", function()
  runner.run_all(true)
end, { desc = "run all cells of all languages", silent = true })
