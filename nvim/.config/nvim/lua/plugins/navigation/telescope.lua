-- TODO: добить найстроку telescope
local function find_nvim_files()
  require('telescope.builtin').find_files({
    prompt_title = "Nvim config fles",
    cwd = vim.fn.stdpath("config"),
  })
end

-- https://github.com/polirritmico/telescope-lazy-plugins.nvim?tab=readme-ov-file#-lazy-loading
local load_extension_after_telescope_is_loaded = function(extension_name)
  local lazy_cfg = require("lazy.core.config").plugins
  if lazy_cfg["telescope.nvim"] and lazy_cfg["telescope.nvim"]._.loaded then
    -- Since Telescope is loaded, just load the extension:
    require("telescope").load_extension(extension_name)
  else
    -- If Telescope is not loaded, create an autocmd that will load the
    -- extension after Telescope is loaded.
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == "telescope.nvim" then
          require("telescope").load_extension(extension_name)
          return true
        end
      end,
    })
  end
end

-- TODO: разобраться с lazy telescope extension
-- https://github.com/polirritmico/telescope-lazy-plugins.nvim
-- telescope-fzf-native
-- https://github.com/AckslD/nvim-neoclip.lua (или разобраться с регистрами)
return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  enabled = true,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    {
      "polirritmico/telescope-lazy-plugins.nvim",
      keys = {
        { '<leader>fN', function() require("telescope").extensions.lazy_plugins.lazy_plugins() end, desc = 'Telescope lazy plugins' }
      }
    },
    {
      enabled = true,
      "nvim-telescope/telescope-ui-select.nvim",
      config = function()
        require("telescope").load_extension("ui-select")
      end,
    },
    {
      -- "benfowler/telescope-luasnip.nvim",
      "SPLYASHKA/telescope-luasnip.nvim",
      enabled = true,
      dir = "/Users/splyashka/Kal/nvim_plugs/sandbox/telescope-luasnip.nvim/",
      dependencies = "nvim-telescope/telescope.nvim",
      -- NOTE: тут вроде можно просто config вместо init lazy_load использовать
      init = function()
        load_extension_after_telescope_is_loaded("luasnip")
      end
    },

  },
  lazy = true,
  opts = {
    defaults = {
      -- path_display = { "smart" },
      -- Default configuration for telescope goes here:
      -- config_key = value,
      mappings = {
        i = {
          -- map actions.which_key to <C-h> (default: <C-/>)
          -- actions.which_key shows the mappings for your picker,
          -- e.g. git_{create, delete, ...}_branch for the git_branches picker
          ["<C-h>"] = "which_key",
          -- https://github.com/nvim-telescope/telescope.nvim/issues/499
          ["<C-u>"] = false,
          ["<C-f>"] = "preview_scrolling_down",
          ["<C-b>"] = "preview_scrolling_up",
        }
      },
    },
    pickers = {
      find_files = {
        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      },
      extensions = {
        ---@module "telescope._extensions.lazy_plugins"
        ---@type TelescopeLazyPluginsUserConfig
        lazy_plugins = {
          lazy_config = vim.fn.stdpath("config") .. "/lua/core/lazy.lua",
        },
      }
    },
  },
  keys = {
    { '<leader>ff', function() require('telescope.builtin').find_files() end,                   desc = 'Telescope find files' },
    { '<leader>fg', function() require('telescope.builtin').live_grep() end,                    desc = 'Telescope live grep' },
    { '<leader>fb', function() require('telescope.builtin').buffers() end,                      desc = 'Telescope buffers' },
    { '<leader>fh', function() require('telescope.builtin').help_tags() end,                    desc = 'Telescope help tags' },
    { '<leader>ft', function() require('telescope.builtin').builtin() end,                      desc = 'Telescope builtins' },
    { '<leader>fp', function() require('plugins._config.telescope-config').project_files() end, desc = 'Telescope find project files' },
    { '<leader>fn', find_nvim_files,                                                            desc = 'Telescope nvim config files' },
    { '<leader>gs', function() require('telescope.builtin').git_status() end,                   desc = 'Telescope git status' },
  },
}
