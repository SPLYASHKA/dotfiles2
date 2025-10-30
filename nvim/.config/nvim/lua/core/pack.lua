-- [[ Add optional packages ]]
-- Nvim comes bundled with a set of packages that are not enabled by
-- default. You can enable any of them by using the `:packadd` command.

-- For example, to add the "nohlsearch" package to automatically turn off search highlighting after
-- 'updatetime' and when going to insert mode
-- vim.cmd('packadd! nohlsearch')  -- will not load, lazy.nvim disables plugin loading completely (vim.go.loadplugins = false).
vim.cmd.packadd("nohlsearch")
