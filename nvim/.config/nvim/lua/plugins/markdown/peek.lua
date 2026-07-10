-- https://github.com/toppair/peek.nvim
-- need deno for build, use Lazy reinstall if failed in first attempt
return {
  -- "toppair/peek.nvim",
  "SPLYASHKA/peek.nvim",
  dev = false,
  ft = { "markdown" },
  build = "deno task --quiet build:fast",
  opts = {
    pdf_map = os.getenv("PEEK_PDF_MAP"),
    -- app = 'firefox', -- app_direct = false
    app = { 'open', '-n', '-a', 'firefox', '--args', '--new-window' },
    app_direct = true,
  },
}
