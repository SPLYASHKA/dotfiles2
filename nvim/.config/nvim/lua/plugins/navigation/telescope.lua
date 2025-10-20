local builtin = require('telescope.builtin') -- TODO: lazy load (function in keys for example)

-- TODO: добить найстроку telescope
return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  -- or                              , branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
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
          ["<C-h>"] = "which_key"
        }
      }
    },
  },
  keys = {
    {'<leader>ff', builtin.find_files, desc = 'Telescope find files' },
    {'<leader>fg', builtin.live_grep, desc = 'Telescope live grep' },
    {'<leader>fb', builtin.buffers, desc = 'Telescope buffers' },
    {'<leader>fh', builtin.help_tags, desc = 'Telescope help tags' },
    {'<leader>ft', builtin.builtin, desc = 'Telescope builtins' },
  },
}
