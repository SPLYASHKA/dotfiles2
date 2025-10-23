vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    local opt_local = vim.opt_local
    opt_local.spell = true
    opt_local.spelllang = { "en_us", "ru" }
  end,
})

vim.keymap.set("n", "<leader>sp", function()
  vim.opt_local.spell = not vim.opt_local.spell:get()
  print("Spell checking " .. (vim.opt_local.spell:get() and "enabled" or "disabled"))
end, { desc = "Toggle spell check" })
