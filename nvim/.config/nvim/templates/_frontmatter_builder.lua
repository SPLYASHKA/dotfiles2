return function(ctx)
  ctx.frontmatter = ctx.frontmatter or {} -- если нет, создаём пустой

  local lines = { "---" }

  for key, value in pairs(ctx.frontmatter) do
    table.insert(lines, string.format("%s: %s", key, value))
  end

  table.insert(lines, "---")

  return lines
end