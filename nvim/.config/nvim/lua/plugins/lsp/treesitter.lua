return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter').install { 'cpp', 'latex' }
    end
  },
}
