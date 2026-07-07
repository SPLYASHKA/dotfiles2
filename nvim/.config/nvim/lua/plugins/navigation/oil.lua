-- https://github.com/stevearc/oil.nvim
return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    skip_confirm_for_simple_edits = true,
    keymaps = {
      ["<Esc>"] = { "actions.close", mode = "n" },
    },
    float = {
      preview_split = "right",
    }
  },
  -- Optional dependencies
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  keys = {
    -- { '<leader>o', function() require("oil").toggle_float(nil, { preview = { vertical = true } }) end, desc = 'Telescope find files' },
    { '<leader>o', function() require("oil").toggle_float() end, desc = 'Toggle float oil' },
  },
}
