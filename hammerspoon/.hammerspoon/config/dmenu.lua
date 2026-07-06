-- local appList = hs.application.runningApplications()
-- local choices = {}
--
-- for _, app in pairs(appList) do
--   table.insert(choices, { ["text"] = app:name() })
-- end
--
-- hs.chooser.new(function(choice)
--   if choice then
--     hs.application.launchOrFocus(choice.text)
--   end
-- end)
--     :choices(choices)
--     :show()
-- Launcher по аналогии с dmenu
local function appLauncher()
  -- собираем список приложений
  local apps = hs.application.runningApplications()
  local choices = {}

  -- добавляем все запущенные приложения
  for _, app in pairs(apps) do
    table.insert(choices, { text = app:name(), subText = "Running" })
  end

  -- можно добавить все приложения из /Applications
  local fs = require("hs.fs")
  for file in fs.dir("/Applications") do
    if file:match("%.app$") then
      local name = file:gsub("%.app$", "")
      table.insert(choices, { text = name, subText = "/Applications" })
    end
  end

  -- создаем chooser
  hs.chooser.new(function(choice)
    if choice then
      hs.application.launchOrFocus(choice.text)
    end
  end)
      :choices(choices)
      :placeholderText("Type app name…")
      :show()
end

-- привязка к хоткею Alt+Space
hs.hotkey.bind({ "alt" }, "space", appLauncher)
