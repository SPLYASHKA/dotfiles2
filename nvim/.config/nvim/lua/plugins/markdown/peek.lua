-- https://github.com/toppair/peek.nvim
-- need deno for build, use Lazy reinstall if failed in first attempt
return {
  "toppair/peek.nvim",
  ft = { "markdown" },
  build = "deno task --quiet build:fast",
  opts = {
  },
  keys = {
    { "<leader>mp", function() require("peek").open() end, desc = "Open Peek markdown preview" }
  },
}
