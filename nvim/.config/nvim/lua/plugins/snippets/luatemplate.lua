return {
  "splyashka/LuaTemplate",
  dependencies = { 'nvim-telescope/telescope.nvim' },
  -- opts = {
  --   templates_dir = vim.fn.stdpath("config") .. "/templates_new", -- настраиваем путь к шаблонам
  -- },
  keys = {
    {
      "<leader>n",
      function()
        require("luatemplate").pick_template()
      end,
      desc = "New from template"
    }
  }
}
