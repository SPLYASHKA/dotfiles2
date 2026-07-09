return {
  "benlubas/molten-nvim",
  dependencies = {
    "3rd/image.nvim",
  },
  -- version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
  build = ":UpdateRemotePlugins",
  init = function()
    -- this is an example, not a default. Please see the readme for more configuration options
    vim.g.molten_output_win_max_height = 12
    -- vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin") .. "/python3"
    vim.g.molten_output_virt_lines = true

    -- this guide will be using image.nvim
    -- Don't forget to setup and install the plugin if you want to view image outputs
    vim.g.molten_image_provider = "image.nvim"

    vim.keymap.set("n", "<localleader>ip", function()
      -- local venv = os.getenv("VIRTUAL_ENV")
      local venv = nil
      if venv ~= nil then
        -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
        venv = string.match(venv, "/.+/(.+)")
        vim.cmd(("MoltenInit %s"):format(venv))
      else
        vim.cmd("MoltenInit python3")
      end
    end, { desc = "Initialize Molten for python3", silent = true, noremap = true })


    vim.api.nvim_create_autocmd("User", {
      pattern = "MoltenInitPost",
      callback = function()
        -- setup some molten specific keybindings
        vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>",
          { desc = "evaluate operator", silent = true })
        vim.keymap.set("n", "<localleader>r", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
        vim.keymap.set("n", "<localleader>R", ":MoltenReevaluateAll<CR>", { desc = "re-eval all", silent = true })
        -- vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv",
        vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>",
          { desc = "execute visual selection", silent = true })
        vim.keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>",
          { desc = "open output window", silent = true })
        vim.keymap.set("n", "<localleader>yo", ":MoltenYankOutput!<CR>",
          { desc = "yank molten output", silent = true })
        vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
        vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })
        local open = false
        vim.keymap.set("n", "<localleader>ot", function()
          open = not open
          vim.fn.MoltenUpdateOption("auto_open_output", open)
        end)

        -- if we're in a python file, change the configuration a little
        if vim.bo.filetype == "python" then
          vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", false)
          vim.fn.MoltenUpdateOption("molten_virt_text_output", false)
        end
      end,
    })
  end,
}
