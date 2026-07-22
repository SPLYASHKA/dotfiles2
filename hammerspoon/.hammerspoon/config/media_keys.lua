media_keys_tap = hs.eventtap.new({ hs.eventtap.event.types.systemDefined }, function(event)
  local data = event:systemKey()
  if not data then return false, nil end

  if data["key"] ~= "PLAY" and data["key"] ~= "FAST" and data["key"] ~= "REWIND" then
    return false, nil
  end

  if data["down"] == false then
    if data["key"] == "PLAY" then
      hs.execute("/opt/homebrew/bin/mpc toggle")
    elseif data["key"] == "FAST" then
      hs.execute("/opt/homebrew/bin/mpc next")
    elseif data["key"] == "REWIND" then
      hs.execute("/opt/homebrew/bin/mpc prev")
    end
  end

  return true, nil
end)
media_keys_tap:start()
