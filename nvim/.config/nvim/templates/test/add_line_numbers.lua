return function(ctx)
  local result = {}

  for i, line in ipairs(ctx.buffer_content) do
    table.insert(result, string.format("%d  %s", i, line))
  end

  return result
end
