-- TODO: добить найстроку telescope
-- TODO: мб скачать телескоп ui
local function find_nvim_files()
  require('telescope.builtin').find_files({
    prompt_title = "Nvim config fles",
    cwd = vim.fn.stdpath("config"),
  })
end

return {
  'nvim-telescope/telescope.nvim',
  enabled = true,
  tag = '0.1.8',
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
  },
}
