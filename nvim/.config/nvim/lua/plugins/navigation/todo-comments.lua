return {
  "folke/todo-comments.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    'nvim-telescope/telescope.nvim',
  },
  lazy = true,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    { "<leader>td", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
    {
      "<leader>tn", 
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next todo comment",

    },
    {
      "<leader>tp", 
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous todo comment",

    },
  },
}
