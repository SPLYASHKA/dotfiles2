-- TODO: можно сделать на маке чтобы пдфка открывалась и обновялалсь ну и линки
return {
  "lervag/vimtex",
  enabled = true,
  lazy = true, -- we don't want to lazy load VimTeX UPD: why?
  ft = "tex",
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    local g = vim.g
    local opt = vim.opt

    g.vimtex_view_method = "zathura"
    g.tex_flavor = 'latex'
    g.vimtex_quickfix_mode = 0
    -- opt.conceallevel = 1
    g.tex_conceal = 'adbmg'
  end,
  config = function()
    local opt = vim.opt
    opt.conceallevel = 1
  end
}
