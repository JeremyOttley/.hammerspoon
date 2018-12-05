------------
-- SETTINGS
------------

local mod1 = {"cmd", "shift"} -- Movement
local mod2 = {"cmd", "ctrl"} -- Resizing
local mod3 = {"alt", "shift"} -- Movement slower
local mod4 = {"alt", "ctrl"} -- Resizing slower

hs.hotkey.bind(mod1,"R", function()
  hs.reload()
end)

------------
-- MOVEMENT
------------

hs.hotkey.bind(mod1,"Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 15
  win:setFrame(f)
end)

hs.hotkey.bind(mod1,"Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + 15
  win:setFrame(f)
end)

hs.hotkey.bind(mod1,"Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y - 15
  win:setFrame(f)
end)

hs.hotkey.bind(mod1,"Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y + 15
  win:setFrame(f)
end)

hs.hotkey.bind(mod3,"Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 5
  win:setFrame(f)
end)

hs.hotkey.bind(mod3,"Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + 5
  win:setFrame(f)
end)

hs.hotkey.bind(mod3,"Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y - 5
  win:setFrame(f)
end)

hs.hotkey.bind(mod3,"Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y + 5
  win:setFrame(f)
end)

------------
-- RESIZING
------------

hs.hotkey.bind(mod2,"Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.w = f.w - 15
  win:setFrame(f)
end)

hs.hotkey.bind(mod2,"Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.w = f.w + 15
  win:setFrame(f)
end)

hs.hotkey.bind(mod2,"Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.h = f.h - 15
  win:setFrame(f)
end)

hs.hotkey.bind(mod2,"Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.h = f.h + 15
  win:setFrame(f)
end)

hs.hotkey.bind(mod4,"Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.w = f.w - 5
  win:setFrame(f)
end)

hs.hotkey.bind(mod4,"Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.w = f.w + 5
  win:setFrame(f)
end)

hs.hotkey.bind(mod4,"Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.h = f.h - 5
  win:setFrame(f)
end)

hs.hotkey.bind(mod4,"Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.h = f.h + 5
  win:setFrame(f)
end)
