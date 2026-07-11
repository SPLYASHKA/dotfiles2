local keymap = vim.keymap

keymap.set({ 'n' }, '<leader>p',
  "<cmd>TeXpresso %<cr>",
  { buffer = true, desc = "TeXpresso this file" }
)

vim.keymap.set("n", "<leader>z", function()
  local has_telescope, telescope = pcall(require, "telescope.builtin")
  if not has_telescope then
    error("Telescope не установлен")
  end


  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local file_pdf = vim.fn.expand("%:r") .. ".pdf"

  local function open_zathura(path)
    -- jobstart без detach — процесс станет дочерним Neovim
    vim.fn.jobstart({ "zathura", path })
  end

  if vim.fn.filereadable(file_pdf) == 1 then
    -- Если файл есть, запускаем Zathura
    open_zathura(file_pdf)
  else
    -- Если нет — открываем Telescope для выбора PDF в текущей директории
    telescope.find_files({
      prompt_title = "Select PDF",
      cwd = vim.fn.expand("%:p:h"),
      find_command = { "fd", "--type", "f", "--extension", "pdf" },
      previewer = false,
      attach_mappings = function(prompt_bufnr, map)
        -- Переопределяем Enter
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          if selection then
            open_zathura(selection.path or selection[1])
          end
          actions.close(prompt_bufnr)
        end)
        return true
      end,
    })
  end
end, { desc = "Open PDF in Zathura or pick with Telescope" })

-- TODO: сделать еще мб toggle, уже открытая будет закрываться
-- хранить для этого Job id
