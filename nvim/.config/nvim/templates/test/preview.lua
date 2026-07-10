local tp = require("luatemplate")

return function(ctx)
  local selector = tp.load_template("edu/_course_selector.lua")

  local new_lines = selector(ctx)

  ctx.frontmatter['Semester'] = nil

  local frontmatter_builder = tp.load_template("_markdown_util/_frontmatter_builder.lua")

  local lines = {}

  vim.list_extend(lines, frontmatter_builder(ctx))

  ctx.filename = "note_" .. ctx.frontmatter["Discipline"]

  vim.list_extend(lines, {
    "x<-- cursor",
    "eof",
  })

  ctx.cursor = { #lines - 1, 0 }

  return lines
end
