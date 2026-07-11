-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects?tab=readme-ov-file
return {
  enabled = true,
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  init = function()
    -- Disable entire built-in ftplugin mappings to avoid conflicts.
    -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
    vim.g.no_plugin_maps = true

    -- Or, disable per filetype (add as you like)
    -- vim.g.no_python_maps = true
    -- vim.g.no_ruby_maps = true
    -- vim.g.no_rust_maps = true
    -- vim.g.no_go_maps = true
  end,
  opts = {
    select = {
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V',  -- linewise
        -- ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true of false
      include_surrounding_whitespace = false,
    },
    move = {
      -- whether to set jumps in the jumplist
      set_jumps = true,
    },
  },
  keys = {
    {
      mode = { "x", "o" },
      "af",
      function()
        require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
      end
    },
    {
      mode = { "x", "o" },
      "if",
      function()
        require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
      end
    },
    {
      mode = { "x", "o" },
      "ac",
      function()
        require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
      end
    },
    {
      mode = { "x", "o" },
      "ic",
      function()
        require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
      end
    },
    -- You can also use captures from other query groups like `locals.scm`
    {
      mode = { "x", "o" },
      "as",
      function()
        require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
      end
    },

    -- swap parameter
    {
      mode = "n",
      "<leader>a",
      function()
        require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
      end
    },
    {
      mode = "n",
      "<leader>A",
      function()
        require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.inner"
      end
    },
    -- functions
    {
      mode = "n",
      "<leader>sfn",
      function() require("nvim-treesitter-textobjects.swap").swap_next "@function.outer" end,
    },
    {
      mode = "n",
      "<leader>sfp",
      function()
        require("nvim-treesitter-textobjects.swap").swap_previous "@function.outer"
      end
    },
    {
      mode = "n",
      "<leader>snn",
      function() require("nvim-treesitter-textobjects.swap").swap_next "@number.outer" end,
    },
    {
      mode = "n",
      "<leader>snp",
      function()
        require("nvim-treesitter-textobjects.swap").swap_previous "@number.outer"
      end
    },
    -- move
    -- move to next start
    {
      mode = { "n", "x", "o" },
      "]f",
      function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
      end
    },
    {
      mode = { "n", "x", "o" },
      "]]",
      function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
      end
    },
    {
      mode = { "n", "x", "o" },
      "]o",
      function()
        require("nvim-treesitter-textobjects.move").goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
      end
    },
    {
      mode = { "n", "x", "o" },
      "]s",
      function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
      end
    },
    {
      mode = { "n", "x", "o" },
      "]z",
      function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
      end
    },

    -- move to next end
    {
      mode = { "n", "x", "o" },
      "]F",
      function()
        require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
      end
    },
    {
      mode = { "n", "x", "o" },
      "][",
      function()
        require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
      end
    },

    -- move to previous start
    {
      mode = { "n", "x", "o" },
      "[f",
      function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
      end
    },
    {
      mode = { "n", "x", "o" },
      "[[",
      function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
      end
    },

    -- move to previous end
    {
      mode = { "n", "x", "o" },
      "[F",
      function()
        require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
      end
    },
    {
      mode = { "n", "x", "o" },
      "[]",
      function()
        require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
      end
    },

    -- move to next/previous conditional
    {
      mode = { "n", "x", "o" },
      "]i",
      function()
        require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
      end
    },
    {
      mode = { "n", "x", "o" },
      "[i",
      function()
        require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
      end
    },
  },
}
