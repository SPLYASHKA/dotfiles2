return {
  enabled = true,
  'barelief/buftyper.nvim',
  config = function()
    require('buftyper').setup({
      show_wpm = true,
      show_mode_indicator = false,
    })
  end
}
