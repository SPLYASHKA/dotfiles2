return {
  "rmagatti/goto-preview",
  dependencies = { "rmagatti/logger.nvim" },
  event = "BufEnter",
  config = {
    opacity = 10,
  },
  keys = {
    { '<A-]>',           function() require('goto-preview').goto_preview_definition() end, desc = 'Goto preview definition' },
    { '<A-g><A-r><A-r>', function() require('goto-preview').goto_preview_references() end, desc = 'Goto preview references' },
  }
}
