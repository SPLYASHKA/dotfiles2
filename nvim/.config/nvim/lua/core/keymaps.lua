-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- [[ Set up keymaps ]] See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`
local keymap = vim.keymap

keymap.set('i', 'jj', '<ESC>', { desc = "Exit insert mode" })


-- Use <Esc> to exit terminal mode
keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
keymap.set({ 'n' }, '<A-h>', '<C-w>h')
keymap.set({ 'n' }, '<A-j>', '<C-w>j')
keymap.set({ 'n' }, '<A-k>', '<C-w>k')
keymap.set({ 'n' }, '<A-l>', '<C-w>l')

keymap.set('n', '<leader>rn',
  function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
  end,
  { desc = "Toggle 'relativenumber'" }
)
