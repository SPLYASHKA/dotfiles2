return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = {
        registries = {
          "github:mason-org/mason-registry",
          -- TODO: вроде добавили в mason-org roslyn, roslyn_ls
          "github:Crashdummyy/mason-registry",
        },

      },
    },
    "neovim/nvim-lspconfig",
  },
  opts = {
    ensure_installed = { "marksman" },
  }
}
