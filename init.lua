<<<<<<< HEAD
=======
require("extras/cheaphints")
--require("extras/redshift")

>>>>>>> 54526c2db776cf52640da24c57b662711e58280f
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
--hs.alert.show("Hammerspoon ready!", 3)
hs.alert.show("Config loaded 👍", 3)

-- modkeys/chords
modkey = {"cmd","alt"}

-- {'⌘', '⌥', 'ctrl'}
hyper = {'ctrl', 'alt', 'cmd'}

--{'⌘', '⌥', '⇧', 'ctrl'}
--hyperShift = {'ctrl', 'alt', 'cmd', 'shift'}
hyperShift = {'ctrl', 'shift'}
<<<<<<< HEAD
=======

-- Modules
local fnutils = hs.fnutils
local each = fnutils.each
local partial = fnutils.partial
local concat = fnutils.concat
local indexOf = fnutils.indexOf

local eventtap = hs.eventtap
local keyStroke = eventtap.keyStroke

local app = hs.application
local frontmost = app.frontmostApplication
local watcher = app.watcher
local get = app.get
local launchOrFocus = app.launchOrFocus

local screen = hs.screen
local allScreens = screen.allScreens
local mainScreen = screen.mainScreen
local setPrimary = screen.setPrimary

local grid = hs.grid

-- Other local variables
local shift = 0.075
>>>>>>> 54526c2db776cf52640da24c57b662711e58280f

--
-- [[ Functions ]] --
--

-- open
function open(name)
    return function()
        app.launchOrFocus(name)
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

hs.loadSpoon("Lunette")

-- customBindings = {
--   center = {
--     {{modkey}, "C"},
--   }
--   fullScreen = {
-- 	{{modkey}, "F"},
--   }
--   leftHalf = {
--   {{modkey}, "left"},
--   }
--   rightHalf = {
--   {{modkey}, "right"},
--   }
--   topHalf = {
--  {{modkey}, "up"},
--  }
--  bottomHalf = {
--  {{modkey}, "down"}
--  }
  --undo = false,
  --redo = false
--}

--spoon.Lunette:bindHotkeys(customBindings)
spoon.Lunette:bindHotkeys()

--[[GRID]]--

<<<<<<< HEAD
local grid = hs.grid
=======
-- Set grid size.
grid.GRIDWIDTH  = 12
grid.GRIDHEIGHT = 12
grid.MARGINX    = 0
grid.MARGINY    = 0
-- Set window animation off. It's much smoother.
hs.window.animationDuration = 0
-- Set volume increments
local volumeIncrement = 5

--hs.hotkey.bind(hyper, ';', function() grid.snap(hs.window.focusedWindow()) end)
--hs.hotkey.bind(hyper, "'", function() hs.fnutils.map(hs.window.visibleWindows(), grid.snap) end)

hs.hotkey.bind(hyper,      '=', function() grid.adjustWidth(1)   end)
hs.hotkey.bind(hyper,      '-', function() grid.adjustWidth(-1)  end)
hs.hotkey.bind(hyperShift, '=', function() grid.adjustHeight(1)  end)
hs.hotkey.bind(hyperShift, '-', function() grid.adjustHeight(-1) end)

hs.hotkey.bind(hyperShift, 'left',  function() hs.window.focusedWindow():focusWindowWest()  end)
hs.hotkey.bind(hyperShift, 'H',  function() hs.window.focusedWindow():focusWindowWest()  end)
hs.hotkey.bind(hyperShift, 'right', function() hs.window.focusedWindow():focusWindowEast()  end)
hs.hotkey.bind(hyperShift, 'L', function() hs.window.focusedWindow():focusWindowEast()  end)
hs.hotkey.bind(hyperShift, 'up',    function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind(hyperShift, 'K',    function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind(hyperShift, 'down',  function() hs.window.focusedWindow():focusWindowSouth() end)
hs.hotkey.bind(hyperShift, 'J',  function() hs.window.focusedWindow():focusWindowSouth() end)

hs.hotkey.bind(hyper, 'M', grid.maximizeWindow)
>>>>>>> 54526c2db776cf52640da24c57b662711e58280f

grid.GRIDWIDTH  = 12
grid.GRIDHEIGHT = 12
grid.MARGINX    = 0
grid.MARGINY    = 0

<<<<<<< HEAD
--
-- [[ Commands ]] --
--

hs.hotkey.bind(hyper, 'M', grid.maximizeWindow)

hs.hotkey.bind(hyper, 'N', grid.pushWindowNextScreen)
hs.hotkey.bind(hyper, 'P', grid.pushWindowPrevScreen)
=======
hs.hotkey.bind(hyper, 'N', grid.pushWindowNextScreen)
hs.hotkey.bind(hyper, 'P', grid.pushWindowPrevScreen)

hs.hotkey.bind(hyper, 'J', grid.pushWindowDown)
hs.hotkey.bind(hyper, 'K', grid.pushWindowUp)
hs.hotkey.bind(hyper, 'H', grid.pushWindowLeft)
hs.hotkey.bind(hyper, 'L', grid.pushWindowRight)

hs.hotkey.bind(hyper, 'U', grid.resizeWindowTaller)
hs.hotkey.bind(hyper, 'O', grid.resizeWindowWider)
hs.hotkey.bind(hyper, 'I', grid.resizeWindowThinner)
hs.hotkey.bind(hyper, 'Y', grid.resizeWindowShorter)
>>>>>>> 54526c2db776cf52640da24c57b662711e58280f

hs.hotkey.bind(hyper, 'J', grid.pushWindowDown)
hs.hotkey.bind(hyper, 'K', grid.pushWindowUp)
hs.hotkey.bind(hyper, 'H', grid.pushWindowLeft)
hs.hotkey.bind(hyper, 'L', grid.pushWindowRight)

hs.hotkey.bind(hyper, 'U', grid.resizeWindowTaller)
hs.hotkey.bind(hyper, 'O', grid.resizeWindowWider)
hs.hotkey.bind(hyper, 'I', grid.resizeWindowThinner)
hs.hotkey.bind(hyper, 'Y', grid.resizeWindowShorter)

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
--app.launchOrFocus("Microsoft Excel")
--app.launchOrFocus("Adobe Acrobat Pro")
--app.launchOrFocus("Microsoft Outlook")
hs.hotkey.bind({"ctrl"}, 'R', "Sublime Text", function () app.launchOrFocus("Sublime Text") end)

hs.hotkey.bind({"alt", "shift"}, 'X', function()
  app.launchOrFocus("Microsoft Excel")
      end)

hs.hotkey.bind({"alt", "shift"}, 'O', function()
  app.launchOrFocus("Microsoft Outlook")
      end)


--hs.hotkey.bind({"alt"}, '<>', function()
--  app.launchOrFocus("Adobe Acrobat Pro")
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


hs.hotkey.bind({"cmd", "alt"},"0",function()
  local proofingLayout = {
    {"Acrobat", nil, nil, hs.layout.right50, nil, nil},
    --{"Google Chrome", nil, nil, hs.layout.left50, nil, nil},
   }
    hs.layout.apply(proofingLayout)

  aacrobat = hs.appfinder.appFromName("Acrobat")
  aacrobat:selectMenuItem({"View","Zoom", "Zoom to Page Level"})
  aacrobat:activate()
end)

hs.hotkey.bind({"cmd", "alt"}, '9', function()
  app.launchOrFocus('Sublime Text')
  app.launchOrFocus('Google Chrome')
  local editorLayout = {
  {"Sublime Text", nil, nil, hs.layout.right50, nil, nil},
  {"BBedit", nil, nil, hs.layout.right50, nil, nil},
}
  hs.layout.apply(editorLayout)
  -- Doesn't work yet. Why?      
  subl = hs.appfinder.appFromName("Sublime Text")
  subl:selectMenuItem({"Find","Replace"})
  subl:activate()
<<<<<<< HEAD
end)
=======
end)
>>>>>>> 54526c2db776cf52640da24c57b662711e58280f
