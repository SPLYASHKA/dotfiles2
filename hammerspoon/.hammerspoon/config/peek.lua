local wf = hs.window.filter.new(false):setDefaultFilter {}

wf:subscribe(hs.window.filter.windowCreated, function(win)
  local title = win:title() or ""
  local app = win:application():name() or ""

  if title:match("Peek preview") or title:match("Markdown Preview") then
    local screen = win:screen()
    local frame = screen:frame()

    -- Ставим окно Peek на левую половину
    win:setFrame({
      x = frame.x,
      y = frame.y,
      w = frame.w / 2,
      h = frame.h
    })

    -- Через полсекунды вернуть фокус на kitty
    hs.timer.doAfter(0.1, function()
      local iterm = hs.application.find("kitty")
      if iterm then
        iterm:activate()
      else
        hs.alert("kitty not found")
      end
    end)
  end
end)
