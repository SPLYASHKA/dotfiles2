local tp = require("luatemplate")

return function(ctx)
  local selector = tp.load_template("_course_selector.lua")

  local new_lines = selector(ctx)

  ctx.frontmatter['Semester'] = nil

  local frontmatter_builder = tp.load_template("_frontmatter_builder.lua")

  local lines = {}

  vim.list_extend(lines, frontmatter_builder(ctx))

  ctx.filename = "note_" .. ctx.frontmatter["Discipline"]

  vim.list_extend(lines, {
    "x<-- cursor",
    "eof",
  })

  vim.schedule(function()
    vim.api.nvim_win_set_cursor(0, { #lines - 1, 0 }) -- строка 5, колонка 0
  end)

  return lines
end
