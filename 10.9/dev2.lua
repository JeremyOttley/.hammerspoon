-- Reload on config change
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Hammerspoon ready!", 3)

printers =  {
  ['309917'] = 'HP LaserJet 600 M602',
}

-- modkeys/chords
modkey = {"cmd","alt"}

-- {'⌘', '⌥', 'ctrl'}
hyper = {'ctrl', 'alt', 'cmd'}

--{'⌘', '⌥', '⇧', 'ctrl'}
hyperShift = {'ctrl', 'alt', 'cmd', 'shift'}

--
-- [[ Functions ]] --
--

-- open
function open(name)
    return function()
        hs.application.launchOrFocus(name)
        if name == 'Finder' then
            hs.appfinder.appFromName(name):activate()
        end
    end
end

-- open key folders with ctrl + key
function directoryLaunchKeyRemap(mods, key, dir)
    local mods = mods or {}
    hs.hotkey.bind(mods, key, function()
        local shell_command = "open " .. dir
        hs.execute(shell_command)
    end)
end

--
-- [[ Windows ]] --
--

-- Set window animation off. It's much smoother.
hs.window.animationDuration = 0

-- Remove window shadows
hs.window.setShadows(true)


-- tile left
hs.hotkey.bind(modkey, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- tile right
hs.hotkey.bind(modkey, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Set volume increments
local volumeIncrement = 5

--hs.hotkey.bind(hyper, ';', function() hs.grid.snap(hs.window.focusedWindow()) end)
--hs.hotkey.bind(hyper, "'", function() hs.fnutils.map(hs.window.visibleWindows(), hs.grid.snap) end)

hs.hotkey.bind(hyper,      '=', function() hs.grid.adjustWidth(1)   end)
hs.hotkey.bind(hyper,      '-', function() hs.grid.adjustWidth(-1)  end)
hs.hotkey.bind(hyperShift, '=', function() hs.grid.adjustHeight(1)  end)
hs.hotkey.bind(hyperShift, '-', function() hs.grid.adjustHeight(-1) end)

hs.hotkey.bind(hyperShift, 'left',  function() hs.window.focusedWindow():focusWindowWest()  end)
hs.hotkey.bind(hyperShift, 'right', function() hs.window.focusedWindow():focusWindowEast()  end)
hs.hotkey.bind(hyperShift, 'up',    function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind(hyperShift, 'down',  function() hs.window.focusedWindow():focusWindowSouth() end)

hs.hotkey.bind(hyper, 'M', hs.grid.maximizeWindow)

hs.hotkey.bind(hyper, 'F', function() hs.window.focusedWindow():toggleFullScreen() end)

hs.hotkey.bind(hyper, 'N', hs.grid.pushWindowNextScreen)
hs.hotkey.bind(hyper, 'P', hs.grid.pushWindowPrevScreen)

hs.hotkey.bind(hyper, 'J', hs.grid.pushWindowDown)
hs.hotkey.bind(hyper, 'K', hs.grid.pushWindowUp)
hs.hotkey.bind(hyper, 'H', hs.grid.pushWindowLeft)
hs.hotkey.bind(hyper, 'L', hs.grid.pushWindowRight)

hs.hotkey.bind(hyper, 'U', hs.grid.resizeWindowTaller)
hs.hotkey.bind(hyper, 'O', hs.grid.resizeWindowWider)
hs.hotkey.bind(hyper, 'I', hs.grid.resizeWindowThinner)
hs.hotkey.bind(hyper, 'Y', hs.grid.resizeWindowShorter)


--
-- [[ Grid ]] --
--

positions = {
  maximized = hs.layout.maximized,
  centered = {x=0.15, y=0.15, w=0.7, h=0.7},

  left34 = {x=0, y=0, w=0.34, h=1},
  left50 = hs.layout.left50,
  left66 = {x=0, y=0, w=0.66, h=1},

  right34 = {x=0.66, y=0, w=0.34, h=1},
  right50 = hs.layout.right50,
  right66 = {x=0.34, y=0, w=0.66, h=1},

  upper50 = {x=0, y=0, w=1, h=0.5},
  upper50Left50 = {x=0, y=0, w=0.5, h=0.5},
  upper50Right50 = {x=0.5, y=0, w=0.5, h=0.5},

  lower50 = {x=0, y=0.5, w=1, h=0.5},
  lower50Left50 = {x=0, y=0.5, w=0.5, h=0.5},
  lower50Right50 = {x=0.5, y=0.5, w=0.5, h=0.5}
}

function bindKey(key, fn)
  hs.hotkey.bind({"cmd", "alt"}, key, fn)
end

grid = {
  {key="u", units={positions.upper50Left50}},
  {key="i", units={positions.upper50}},
  {key="o", units={positions.upper50Right50}},

  {key="j", units={positions.left50, positions.left66, positions.left34}},
  {key="k", units={positions.centered, positions.maximized}},
  {key="l", units={positions.right50, positions.right66, positions.right34}},

  {key="m", units={positions.lower50Left50}},
  {key=",", units={positions.lower50}},
  {key=".", units={positions.lower50Right50}}
}

-- [[ Layout ]] --

hs.fnutils.each(grid, function(entry)
  bindKey(entry.key, function()
    local units = entry.units
    local screen = hs.screen.mainScreen()
    local window = hs.window.focusedWindow()
    local windowGeo = window:frame()

    local index = 0
    hs.fnutils.find(units, function(unit)
      index = index + 1

      local geo = hs.geometry.new(unit):fromUnitRect(screen:frame()):floor()
      return windowGeo:equals(geo)
    end)
    if index == #units then index = 0 end

    window:moveToUnit(units[index + 1])
  end)
end)

hs.fnutils.each(grid, function(entry)
  bindKey(entry.key, function()
    hs.window.focusedWindow():moveToUnit(entry.unit)
  end)
end)

bindKey('9', function()
  hs.layout.apply({
    {"Google Chrome", nil, screen, positions.left50,         nil, nil},
    {"Acrobat",   nil, screen, positions.right50, nil, nil}
  })
  aacrobat = hs.appfinder.appFromName("Acrobat")
  aacrobat:selectMenuItem({"View","Zoom", "Zoom to Page Level"})
  aacrobat:activate()
end)

--
-- [[ Commands ]] --
--

--- quick open folders
directoryLaunchKeyRemap({"ctrl"}, "D", "~/Documents") 

hs.hotkey.bind({"ctrl"}, 'F', function()
      finder = hs.appfinder.appFromName("Finder")
      finder:selectMenuItem({"File","New Finder Window"})
      finder:activate()
      end)


hs.hotkey.bind({"alt"}, 'p', function()
    hs.itunes.pause()
      end)

hs.hotkey.bind({"alt", "shift"}, 'P', function()
    hs.itunes.play()
      end)


-- this works, just bind it to a key
--hs.application.launchOrFocus("Microsoft Excel")
--hs.application.launchOrFocus("Adobe Acrobat Pro")
--hs.application.launchOrFocus("Microsoft Outlook")
hs.hotkey.bind({"ctrl"}, 'R', "Sublime Text", function () hs.application.launchOrFocus("Sublime Text") end)

hs.hotkey.bind({"alt", "shift"}, 'X', function()
  hs.application.launchOrFocus("Microsoft Excel")
      end)

hs.hotkey.bind({"alt", "shift"}, 'O', function()
  hs.application.launchOrFocus("Microsoft Outlook")
      end)


--hs.hotkey.bind({"alt"}, '<>', function()
--  hs.application.launchOrFocus("Adobe Acrobat Pro")
--      end)

-- raise console
hs.hotkey.bind({"cmd", "alt"}, "Y", hs.toggleConsole)

--- key macros
   function keyStrokes(str)
     return function()
         hs.eventtap.keyStrokes(str)
     end
   end
   --hs.hotkey.bind({"alt", "cmd"}, "L", keyStrokes("console.log("))
