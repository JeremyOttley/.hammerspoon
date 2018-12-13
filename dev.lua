--
-- [[ Modules ]] --
--
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

-- Set window animation off. It's much smoother.
hs.window.animationDuration = 0

-- Remove window shadows
hs.window.setShadows(true)

-- Other local variables
local shift = 0.075

-- modkeys/chords
modkey = {"cmd","alt"}

-- {'⌘', '⌥', 'ctrl'}
local hyper = {'ctrl', 'alt', 'cmd'}

--{'⌘', '⌥', '⇧', 'ctrl'}
local hyperShift = {'ctrl', 'alt', 'cmd', 'shift'}

-- init grid --
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.grid.setGrid('2x2')

--
-- [[ Functions ]] --
--

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

-- Launch Applications --
hs.hotkey.bind(hyper, 'T', "Terminal", function () hs.application.launchOrFocus("Terminal") end)
hs.hotkey.bind(hyper, 'R', "Sublime Text", function () hs.application.launchOrFocus("Sublime Text") end)
hs.hotkey.bind(hyper, 'S', "Safari", function () hs.application.launchOrFocus("Safari") end)
hs.hotkey.bind(hyper, 'F', "Finder", function () hs.application.launchOrFocus("Finder") end)


-- Organize Windows --

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

hs.hotkey.bind(hyper, 'W', hs.grid.maximizeWindow)

--hs.hotkey.bind(hyper_cmd, 'D', hs.grid.pushWindowRight)
--hs.hotkey.bind(hyper_cmd, 'A', hs.grid.pushWindowLeft)

function toUpper ()
	function fn (cell)
		cell.y = 0
		cell.x = 0
		cell.w = 2
		cell.h = 1
		return hs.grid
	end
	hs.grid.adjustWindow(fn)
end
hs.hotkey.bind(hyper_cmd, 'W', toUpper)

function toLower ()
	function fn (cell)
		cell.y = 1
		cell.x = 0
		cell.w = 2
		cell.h = 1
		return hs.grid
	end
	hs.grid.adjustWindow(fn)
end
hs.hotkey.bind(hyper_cmd, 'S', toLower)

function toUpperLeft ()
	function fn (cell)
		cell.y = 0
		cell.x = 0
		cell.w = 1
		return hs.grid
	end
	hs.grid.adjustWindow(fn)
end
hs.hotkey.bind(hyper, 'Q', toUpperLeft)

function toUpperRight ()
	function fn (cell)
		cell.y = 0
		cell.x = 1
		cell.w = 1
		return hs.grid
	end
	hs.grid.adjustWindow(fn)
end
hs.hotkey.bind(hyper, 'E', toUpperRight)

function toLowerRight ()
	function fn (cell)
		cell.h = 1
		cell.w = 1
		cell.y = 1
		cell.x = 1
	end
	hs.grid.adjustWindow(fn, window)
end
hs.hotkey.bind(hyper, 'D', toLowerRight)

function toLowerLeft ()
	function fn (cell)
		cell.h = 1
		cell.w = 1
		cell.y = 1
		cell.x = 0
	end
	hs.grid.adjustWindow(fn, window)
end
hs.hotkey.bind(hyper, 'A', toLowerLeft)

-- Window Hints
hs.hotkey.bind(hyper, '.', hs.hints.windowHints)

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
hs.hotkey.bind({"ctrl", "cmd", "alt"}, "Y", hs.toggleConsole)
