local opt_local = vim.opt_local

opt_local.formatoptions:append("r") -- '<CR>' in insert mode
opt_local.formatoptions:append("o") -- '<CR>' in insert mode

opt_local.comments = {
  -- "fb:*,fb:-,fb:+,n:>", -- default
  "b:- [ ]", -- tasks
  "b:- [x]",
  "b:*", -- unordered list
  "b:-",
  "b:+",
  "On:>", -- quote
}
