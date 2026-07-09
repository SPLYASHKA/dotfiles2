-- NOTE: я использую свой fork, пока вот это чудо не вмержат,
-- если реджекнут надо будет переписать <leader>ip мапинг
-- https://github.com/hakonharnes/img-clip.nvim/issues/148
return {
  -- "HakonHarnes/img-clip.nvim",
  "SPLYASHKA/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    -- add options here
    -- or leave it empty to use the default settings
  },
  keys = {
    -- suggested keymap
    { "<leader>P", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    {
      "<leader>ip",
      function()
        local telescope = require("telescope.builtin")
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        telescope.find_files({
          attach_mappings = function(_, map)
            local function embed_image(prompt_bufnr)
              local entry = action_state.get_selected_entry()
              local filepath = entry[1]
              actions.close(prompt_bufnr)

              local img_clip = require("img-clip")
              img_clip.paste_image(nil, filepath)
            end

            map("i", "<CR>", embed_image)
            map("n", "<CR>", embed_image)

            return true
          end,
        })
      end,
      desc = "Telescope img_clip"
    }
  },
}
