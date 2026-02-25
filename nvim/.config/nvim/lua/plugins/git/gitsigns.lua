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
  keys = {
    {
      '<leader>gd',
      diff_with_commit,
      desc = 'Git diff with commit...'
    }
  },
}
