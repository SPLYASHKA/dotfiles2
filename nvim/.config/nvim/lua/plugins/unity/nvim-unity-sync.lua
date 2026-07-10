return {
  "apyra/nvim-unity-sync",
  dependencies = { "nvim-tree/nvim-tree.lua" },
  config = function()
    require("unity.plugin").setup({
      -- Configs here (Optional)
    })
  end,
  ft = "cs",
}
