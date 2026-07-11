-- [[ Basic Autocommands ]].
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`
local function augroup(name)
  return vim.api.nvim_create_augroup("usr_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.cmd("startinsert")
  end,
})

-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Sync clipboard between OS and Neovim. Schedule the setting after `UiEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
-- TODO: подумать нужно ли это
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
      vim.wo[win][0].foldtext = vim.lsp.foldtext()
    end
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/implementation') then
      -- Create a keymap for vim.lsp.buf.implementation ...
    end

    -- NOTE: если включать это чудо, то нужно условно замапить CTRL-Y, потому
    -- что изначально noselect и CTRL-Y do nothing
    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    -- if client:supports_method('textDocument/completion') then
    --   -- Optional: trigger autocompletion on EVERY keypress. May be slow!
    --   local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
    --   client.server_capabilities.completionProvider.triggerCharacters = chars
    --
    --   vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    -- end

    -- Auto-format ("lint") on save.
    -- NOTE: в будущем возможно буду просто conform.nvim использовать
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- https://github.com/nvim-treesitter/nvim-treesitter/discussions/8546
-- vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()]
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if vim.treesitter.language.add(lang or args.match) then
      vim.treesitter.start(args.buf)
    end
  end,
})
