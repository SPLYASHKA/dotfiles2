local setup_cppman = function()
  local cppman = require "cppman"
  cppman.setup()

  -- Open search box
  vim.keymap.set("n", "<leader>cc", function()
    cppman.input()
  end)
end

setup_cppman()
