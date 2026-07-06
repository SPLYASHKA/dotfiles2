local SECTOR_CENTER = 40
local active = false
local origin = nil

local function sector(dx, dy)
  local dist = math.sqrt(dx * dx + dy * dy)
  if dist < SECTOR_CENTER then return "Center" end

  local deg = math.deg(math.atan(dy, dx))
  if deg < 0 then deg = deg + 360 end

  if deg >= 337.5 or deg < 22.5 then
    return "E"
  elseif deg < 67.5 then
    return "SE"
  elseif deg < 112.5 then
    return "S"
  elseif deg < 157.5 then
    return "SW"
  elseif deg < 202.5 then
    return "W"
  elseif deg < 247.5 then
    return "NW"
  elseif deg < 292.5 then
    return "N"
  else
    return "NE"
  end
end

local presets = {
  FullScreen         = function(f) return { x = f.x, y = f.y, w = f.w, h = f.h } end,
  LeftHalf           = function(f) return { x = f.x, y = f.y, w = f.w / 2, h = f.h } end,
  RightHalf          = function(f) return { x = f.x + f.w / 2, y = f.y, w = f.w / 2, h = f.h } end,
  TopHalf            = function(f) return { x = f.x, y = f.y, w = f.w, h = f.h / 2 } end,
  BottomHalf         = function(f) return { x = f.x, y = f.y + f.h / 2, w = f.w, h = f.h / 2 } end,
  TopLeftQuarter     = function(f) return { x = f.x, y = f.y, w = f.w / 2, h = f.h / 2 } end,
  TopRightQuarter    = function(f) return { x = f.x + f.w / 2, y = f.y, w = f.w / 2, h = f.h / 2 } end,
  BottomLeftQuarter  = function(f) return { x = f.x, y = f.y + f.h / 2, w = f.w / 2, h = f.h / 2 } end,
  BottomRightQuarter = function(f) return { x = f.x + f.w / 2, y = f.y + f.h / 2, w = f.w / 2, h = f.h / 2 } end,
}

local throwBindings = {
  W  = presets.LeftHalf,
  E  = presets.RightHalf,
  N  = presets.FullScreen,
  S  = presets.BottomHalf,
  NW = presets.TopLeftQuarter,
  NE = presets.TopRightQuarter,
  SW = presets.BottomLeftQuarter,
  SE = presets.BottomRightQuarter,
}

local function createGhost()
  glob_ghost = hs.canvas.new({ x = 0, y = 0, w = 100, h = 100 })
  glob_ghost:appendElements({
    type = "rectangle",
    fillColor = { alpha = 0.12, white = 1 },
    strokeColor = { alpha = 0.45, white = 1 },
    strokeWidth = 2,
    roundedRectRadii = { xRadius = 6, yRadius = 6 },
  })
  glob_ghost:level(hs.canvas.windowLevels.overlay)
end

local function updateGhost(s, screen)
  if s ~= "Center" and throwBindings[s] then
    glob_ghost:frame(throwBindings[s](screen:frame()))
    glob_ghost:show()
  else
    glob_ghost:hide()
  end
end

local function updatePreview()
  if not active then return end

  local mouse = hs.mouse.absolutePosition()
  local s = sector(mouse.x - origin.x, mouse.y - origin.y)
  local screen = hs.mouse.getCurrentScreen()

  glob_label:frame({ x = mouse.x - 30, y = mouse.y + 16, w = 60, h = 22 })
  glob_label[1].text = s
  updateGhost(s, screen)
end

local function createMarkers()
  local screen = hs.mouse.getCurrentScreen()
  local f = screen:frame()
  local cx = origin.x - f.x
  local cy = origin.y - f.y

  glob_dot = hs.canvas.new({ x = f.x, y = f.y, w = f.w, h = f.h })
  glob_dot:appendElements({
    type = "circle",
    center = { x = cx, y = cy },
    radius = 4,
    fillColor = { alpha = 0.7, white = 1 },
  })
  glob_dot:appendElements({
    type = "circle",
    center = { x = cx, y = cy },
    radius = SECTOR_CENTER,
    strokeWidth = 1.5,
    strokeColor = { alpha = 0.35, white = 1 },
    fillColor = { alpha = 0 },
    strokeDashPattern = { 5, 5 },
  })
  glob_dot:level(hs.canvas.windowLevels.overlay)
  glob_dot:show()
end

local function start()
  active = true
  origin = hs.mouse.absolutePosition()

  createMarkers()
  createGhost()

  glob_label = hs.canvas.new({ x = origin.x - 30, y = origin.y + 16, w = 60, h = 22 })
  glob_label:appendElements({
    type = "text",
    frame = { x = 0, y = 0, w = 60, h = 22 },
    text = "Center",
    textColor = { alpha = 0.9, white = 1 },
    textAlignment = "center",
    textSize = 13,
  })
  glob_label:level(hs.canvas.windowLevels.overlay)
  glob_label:show()

  glob_preview = hs.timer.doEvery(0.04, updatePreview)
end

local function clean()
  if glob_preview then
    glob_preview:stop(); glob_preview = nil
  end
  if glob_dot then
    glob_dot:delete(); glob_dot = nil
  end
  if glob_label then
    glob_label:delete(); glob_label = nil
  end
  if glob_ghost then
    glob_ghost:delete(); glob_ghost = nil
  end
  active = false
  origin = nil
end

local function windowUnderMouse(cursor_pos)
  local _ = hs.application
  local pos = hs.geometry.new(cursor_pos or hs.mouse.absolutePosition())
  local screen = hs.mouse.getCurrentScreen()
  return hs.fnutils.find(hs.window.orderedWindows(), function(w)
    return screen == w:screen() and pos:inside(w:frame())
  end)
end

local function moveWindowExactly(win, frame)
  -- disable AXEnhancedUserInterface if enabled
  local axApp = hs.axuielement.applicationElement(win:application())
  local wasEnhanced = axApp.AXEnhancedUserInterface
  if wasEnhanced then axApp.AXEnhancedUserInterface = false end

  -- win:setFrame(f, 0)
  -- win:setTopLeft({ x = frame.x, y = frame.y })
  -- win:setSize({ w = frame.w, h = frame.h })
  win:setFrame(frame, 0)

  -- enable it back
  if wasEnhanced then axApp.AXEnhancedUserInterface = true end
end

local function throwWindow(s, cursor_pos)
  if s == "Center" then return end
  local preset = throwBindings[s]
  if not preset then return end

  local win = windowUnderMouse(cursor_pos)
  if not win then return end

  local frame = preset(win:screen():frame())
  moveWindowExactly(win, frame)
  win:focus()
end

local function finish()
  if not active then return end
  local mouse = hs.mouse.absolutePosition()
  local s = sector(mouse.x - origin.x, mouse.y - origin.y)
  throwWindow(s, origin)
  clean()
end

local ctrl = false
local cmd = false

glob_tap = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(e)
  local flags = e:getFlags()
  local wasBoth = ctrl and cmd
  ctrl = flags.ctrl or false
  cmd = flags.cmd or false

  if ctrl and cmd and not active then
    start()
  elseif wasBoth and not (ctrl and cmd) and active then
    finish()
  end

  return false
end)

glob_tap:start()
