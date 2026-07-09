return function(ctx)
  ctx.value = "from child"

  return {
    "Child line 1",
    "Child line 2",
  }
end
