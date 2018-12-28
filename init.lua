require("extras/cheaphints")

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

-- modkeys/chords
modkey = {"cmd","alt"}

-- {'⌘', '⌥', 'ctrl'}
hyper = {'ctrl', 'alt', 'cmd'}

--{'⌘', '⌥', '⇧', 'ctrl'}
hyperShift = {'ctrl', 'alt', 'cmd', 'shift'}

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

--[[ Window Filter ]]--
-- set up your windowfilter
-- switcher = hs.window.switcher.new() -- default windowfilter: only visible windows, all Spaces
-- switcher_space = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{}) -- include minimized/hidden windows, current Space only
-- switcher_browsers = hs.window.switcher.new{'Safari','Google Chrome'} -- specialized switcher for your dozens of browser windows :)

-- bind to hotkeys; WARNING: at least one modifier key is required!
-- hs.hotkey.bind('alt','tab','Next window',function()switcher:next()end)
-- hs.hotkey.bind('alt-shift','tab','Prev window',function()switcher:previous()end)

-- alternatively, call .nextWindow() or .previousWindow() directly (same as hs.window.switcher.new():next())
-- hs.hotkey.bind('alt','tab','Next window',hs.window.switcher.nextWindow)
-- you can also bind to `repeatFn` for faster traversing
-- hs.hotkey.bind('alt-shift','tab','Prev window',hs.window.switcher.previousWindow,nil,hs.window.switcher.previousWindow)

--[[GRID]]--

-- Set grid size.
hs.grid.GRIDWIDTH  = 12
hs.grid.GRIDHEIGHT = 12
hs.grid.MARGINX    = 0
hs.grid.MARGINY    = 0
-- Set window animation off. It's much smoother.
hs.window.animationDuration = 0
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


hs.hotkey.bind({"cmd", "alt"},"0",function()
  local proofingLayout = {
    {"Acrobat", nil, nil, hs.layout.right50, nil, nil},
    {"Google Chrome", nil, nil, hs.layout.left50, nil, nil},
   }
    hs.layout.apply(proofingLayout)

  aacrobat = hs.appfinder.appFromName("Acrobat")
  aacrobat:selectMenuItem({"View","Zoom", "Zoom to Page Level"})
  aacrobat:activate()
end)

hs.hotkey.bind({"cmd", "alt"}, '9', function()
  hs.application.launchOrFocus('Sublime Text')
  hs.application.launchOrFocus('Google Chrome')
  local editorLayout = {
  {"Sublime Text", nil, nil, hs.layout.right50, nil, nil},
  {"Google Chrome", nil, nil, hs.layout.left50, nil, nil},
}
  hs.layout.apply(editorLayout)
end)

