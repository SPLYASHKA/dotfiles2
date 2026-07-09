-- TODO: сделать чтобы грузилось только на маке
local hammerspoon_path = vim.env.HOME .. "/.hammerspoon/Spoons/EmmyLua.spoon/annotations"
return {
  settings = {
    Lua = {
      -- codeLens = { enable = true },
      -- hint = { enable = true, semicolon = 'Disable' },
      workspace = {
        library = {
          hammerspoon_path,
        }
      },
    },
  },
}
