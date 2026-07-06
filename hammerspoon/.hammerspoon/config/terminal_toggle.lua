local terminals = {
  { text = "WezTerm", bundleID = "com.github.wez.wezterm" },
  { text = "Kitty",   bundleID = "net.kovidgoyal.kitty" },
}

local SETTINGS_KEY = "terminal_bundle_id"

local function showSelector()
  local chooser = hs.chooser.new(function(choice)
    if choice then
      hs.settings.set(SETTINGS_KEY, choice.bundleID)
      hs.alert("Terminal: " .. choice.text)
    end
  end)
  chooser:choices(terminals)
  chooser:show()
end

local function toggleTerminal()
  local bundleID = hs.settings.get(SETTINGS_KEY)
  if not bundleID then
    showSelector()
    return
  end

  local app = hs.application.get(bundleID)
  if not app then
    hs.application.launchOrFocusByBundleID(bundleID)
    return
  end
  if app:isFrontmost() then
    app:hide()
  else
    app:unhide()
    app:activate()
  end
end

hs.hotkey.bind({ "alt" }, "/", toggleTerminal)
hs.hotkey.bind({ "alt", "shift" }, "/", showSelector)
