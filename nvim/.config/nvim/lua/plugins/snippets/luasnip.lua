return {
  {
    "L3MON4D3/LuaSnip",
    enabled = true,
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    keys = {
      {
        "<C-L>",
        function()
          local ls = require("luasnip")
          if ls.jumpable(1) then
            require("luasnip").jump(1)
          end
        end,
        mode = { "i", "s" },
        desc = "Jump next luasnip",
        silent = true
      },
      {
        "<C-J>",
        function()
          local ls = require("luasnip")
          if ls.jumpable(-1) then
            ls.jump(-1)
          else
            -- передаём обычное Ctrl-J
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-J>", true, false, true), "n", false)
          end
        end,
        mode = { "i", "s" },
        desc = "Jump next luasnip",
        silent = true
      },
      {
        "<C-H>",
        function()
          local ls = require("luasnip")
          if ls.choice_active() then
            ls.change_choice(1)
          end
        end,
        mode = { "i", "s" },
        desc = "Change choice luasnip",
        silent = true
      },
      {
        "<C-Q>",
        function()
          require("luasnip.extras.select_choice")()
        end,
        mode = { "i", "s" },
        desc = "Select choice luasnip",
        silent = true
      }
    },
    config = function()
      local ls = require("luasnip")

      ls.config.setup({
        enable_autosnippets = true,
        update_events = 'TextChanged,TextChangedI',
        ft_func = require("luasnip.extras.filetype_functions").from_cursor_pos,
        load_ft_func = require("luasnip.extras.filetype_functions").extend_load_ft({
          markdown = { "lua", "c" },
        }),
      })

      -- load snippets on lua
      require("luasnip.loaders.from_lua").load({ paths = "./snippets/lua" })
      -- load snippets in snipmate format
      require("luasnip.loaders.from_snipmate").lazy_load({ paths = "./snippets/snipmate" })
      -- load snippets in vscode format
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").load({ paths = "./snippets/vscode" })

      vim.api.nvim_create_user_command("LuaSnipEdit", function()
        require("luasnip.loaders").edit_snippet_files()
      end, {})
    end,
  },
  -- {
  --   "evesdropper/luasnip-latex-snippets.nvim",
  --   enabled = false,
  -- },
  -- {
  --   "iurimateus/luasnip-latex-snippets.nvim",
  --   opts = true,
  -- }
  {
    "benfowler/telescope-luasnip.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require('telescope').load_extension('luasnip')
    end
  },
  {
    "chrisgrieser/nvim-scissors",
    dependencies = "nvim-telescope/telescope.nvim", -- if using telescope
    opts = {
      snippetDir = vim.fn.stdpath("config") .. "/snippets/vscode/",
    }
  },
}
