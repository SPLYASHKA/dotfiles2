local lt = require("luatemplate")

return function(ctx)
  local child = lt.load_template("test/_child.lua")

  local lines = {
    "Parent line 1",
  }

  local child_lines = child(ctx)

  vim.list_extend(lines, child_lines)

  vim.list_extend(lines, {
    "Parent line 2",
    "Value: " .. ctx.value,
  })

  return lines
end
