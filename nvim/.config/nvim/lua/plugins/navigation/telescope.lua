-- TODO: добить найстроку telescope
-- TODO: мб скачать телескоп ui
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
    {'<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Telescope find files' },
    {'<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'Telescope live grep' },
    {'<leader>fb', function() require('telescope.builtin').buffers() end, desc = 'Telescope buffers' },
    {'<leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'Telescope help tags' },
    {'<leader>ft', function() require('telescope.builtin').builtin() end, desc = 'Telescope builtins' },
  },
}
