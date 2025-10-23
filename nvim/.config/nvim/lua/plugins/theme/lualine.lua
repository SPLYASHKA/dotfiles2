return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      always_show_tabline = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
        refresh_time = 16, -- ~60fps
        events = {
          'WinEnter',
          'BufEnter',
          'BufWritePost',
          'SessionLoadPost',
          'FileChangedShellPost',
          'VimResized',
          'Filetype',
          'CursorMoved',
          'CursorMovedI',
          'ModeChanged',
        },
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'lsp_status', 'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {
        'location',
        function()
          local space = vim.fn.search([[\s\+$]], 'nwc')
          return space ~= 0 and "TW:"..space or ""
        end,
      }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {
      lualine_a = {
        {
          'buffers',
          show_filename_only = false,   -- Shows shortened relative path when set to false.
          hide_filename_extension = false,   -- Hide filename extension when set to true.
          show_modified_status = true, -- Shows indicator when the buffer is modified.

          filetype_names = {
            TelescopePrompt = 'Telescope',
            dashboard = 'Dashboard',
            packer = 'Packer',
            fzf = 'FZF',
            alpha = 'Alpha'
          }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )
        },

      }, -- <-- аналог airline tabline
      lualine_z = {'tabs'},    -- можно добавить вкладки, если используешь :tabnew
    },
    winbar = {},
    inactive_winbar = {},
    extensions = {},
    extensions = {'quickfix', 'man'},
  }
}
