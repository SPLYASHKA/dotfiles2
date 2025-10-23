-- [[ Setting options ]] See `:h vim.o`
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:help option-list`
-- To see documentation for an option, you can use `:h 'optionname'`, for example `:h 'number'`
-- (Note the single quotes)
local opt = vim.opt

-- Print the line number in front of each line
opt.number = true
-- Use relative line numbers, so that it is easier to jump with j, k. This will affect the 'number'
-- option above, see `:h number_relativenumber`
opt.relativenumber = true
-- Highlight the line where the cursor is on
opt.cursorline = true
opt.wrap = false
-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- indent settings
-- TODO: почитать про indent еще раз
opt.shiftwidth=2
opt.tabstop=4
opt.softtabstop=4
opt.expandtab=true
opt.smartindent=true

opt.list = true
opt.listchars = { tab = "»·", trail = "-"}
-- opt.listchars:append { space = "·" }
-- opt.listchars:append { eol = "\\u21b5" }

-- TODO: прочитать про форматирование
-- opt.formatoptions = "jcrql"
-- opt.formatoptions:remove {'o'}
-- opt.formatoptions:remove {'l'}
opt.textwidth = 80
