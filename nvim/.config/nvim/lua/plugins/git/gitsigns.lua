-- https://github.com/lewis6991/gitsigns.nvim

local function diff_with_commit()
  local builtin = require("telescope.builtin")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  builtin.git_commits({
    attach_mappings = function(prompt_bufnr, map)
      local function diff_commit()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        if selection and selection.value then
          local commit = selection.value
          vim.cmd("Gitsigns diffthis " .. commit)
        end
      end

      map("i", "<CR>", diff_commit)
      map("n", "<CR>", diff_commit)

      return true
    end,
  })
end

return {
  'lewis6991/gitsigns.nvim',
  lazy = false,
  opts = {
    on_attach = function(bufnr)
      vim.keymap.set('n', '<leader>gd', diff_with_commit, { buf = bufnr, desc = "Git diff with commit..." })
      -- hunk actions
      vim.keymap.set('n', '<leader>hs', require("gitsigns").stage_hunk,
        { buf = bufnr, desc = "Stage/unstage hunk under cursor" })
      vim.keymap.set('n', '<leader>hr', require("gitsigns").reset_hunk, { buf = bufnr, desc = "Reset hunk under cursor" })
      vim.keymap.set('n', '<leader>hp', require("gitsigns").preview_hunk,
        { buf = bufnr, desc = "Preview hunk under cursor" })
      vim.keymap.set('n', ']h', function() require("gitsigns").nav_hunk("next", {}, {}) end,
        { buf = bufnr, desc = "Jump to next hunk" })
      vim.keymap.set('n', '[h', function() require("gitsigns").nav_hunk("prev", {}, {}) end,
        { buf = bufnr, desc = "Jump to prev hunk" })
      vim.keymap.set('n', ']H', function() require("gitsigns").nav_hunk("last", {}, {}) end,
        { buf = bufnr, desc = "Jump to last hunk" })
      vim.keymap.set('n', '[H', function() require("gitsigns").nav_hunk("first", {}, {}) end,
        { buf = bufnr, desc = "Jump to first hunk" })
    end,
  }
}
