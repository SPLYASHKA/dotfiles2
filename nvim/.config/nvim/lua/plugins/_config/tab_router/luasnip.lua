local M = {}

function M.get()
  local ls = require("luasnip")
  if not ls.jumpable(1) then
    return nil
  end

  local dest = ls.jump_destination(1)
  if not dest then
    return nil
  end

  local from_pos = dest:get_buf_position({ raw = true })
  if from_pos then
    return {
      row = from_pos[1] + 1,
      col = from_pos[2],
    }
  end

  return nil
end

return M
