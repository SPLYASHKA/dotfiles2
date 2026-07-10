return function(ctx)
  local filetype = vim.bo[ctx.bufnr].filetype
  local extension = filetype ~= "" and filetype or "txt"

  local wrapped = {
    "```" .. extension,
  }

  for _, line in ipairs(ctx.buffer_content) do
    table.insert(wrapped, line)
  end

  table.insert(wrapped, "```")

  return wrapped
end