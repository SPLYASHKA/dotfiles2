local BUNDLE_ID = "com.tdesktop.Telegram"

hs.hotkey.bind({ "alt" }, "'", function()
  local app = hs.application.get(BUNDLE_ID)

  if not app then
    hs.application.launchOrFocusByBundleID(BUNDLE_ID)
    return
  end

  if app:isFrontmost() then
    app:hide()
  else
    app:unhide()
    app:activate()
  end
end)
