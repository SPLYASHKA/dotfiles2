-- TODO: ну это точно переписать надо на lua
vim.cmd([[
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
]])

-- CopyFilename[!] : filename [fullpath]
vim.api.nvim_create_user_command('CopyFilename', function(opts)
  local path

  if opts.bang then
    path = vim.fn.expand('%:p')
  else
    path = vim.fn.expand('%:t')
  end

  vim.fn.setreg('+', path)
  print('Copied: ' .. path)
end, {
  bang = true,
})

vim.api.nvim_create_user_command("DiffClipboard", function()
  local ft = vim.bo.filetype -- запоминаем filetype текущего буфера

  vim.cmd("vnew")
  vim.cmd("set buftype=nofile noswapfile")
  vim.bo.filetype = ft -- применяем к новому буферу

  vim.cmd('put +')
  vim.cmd("diffthis")

  vim.cmd("wincmd p")
  vim.cmd("diffthis")
end, {})

vim.api.nvim_create_user_command('Scratch', function(args)
  vim.cmd('new')
  vim.opt_local.buftype = 'nofile'
  vim.opt_local.bufhidden = 'hide'
  vim.opt_local.swapfile = false
  if args.args ~= '' then
    vim.cmd('file [Scratch] ' .. args.args)
  end
end, { nargs = '?' })

-- Вертикальное разделение
vim.api.nvim_create_user_command('VScratch', function(args)
  vim.cmd('vnew')
  vim.opt_local.buftype = 'nofile'
  vim.opt_local.bufhidden = 'hide'
  vim.opt_local.noswapfile = true
  if args.args ~= '' then
    vim.cmd('file [Scratch] ' .. args.args)
  end
end, { nargs = '?' })
