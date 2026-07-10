local tp = require("luatemplate")

return function(ctx)
  new_ctx = {}

  local selector = tp.load_template("edu/_course_selector.lua")

  local new_lines = selector(ctx)

  ctx.frontmatter["Assignment"] = vim.env.ASSIGNMENT

  local frontmatter_builder = tp.load_template("_markdown_util/_frontmatter_builder.lua")

  local lines = {}

  vim.list_extend(lines, frontmatter_builder(ctx))

  ctx.filename = "note_" .. ctx.frontmatter["Discipline"]


  ctx.cursor = { #lines, 0 }

  return lines
end
