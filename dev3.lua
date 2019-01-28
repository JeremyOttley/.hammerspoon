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

-- Other local variables
local shift = 0.075

printers =  {
  ['309917'] = 'HP LaserJet 600 M602',
}

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

-- Hammerspoon Hints

hs.hints.style = 'vimperator'
hs.hints.hintChars = { 'A', 'S', 'D', 'F', 'J', 'K', 'L', 'Q', 'W', 'E', 'R', 'Z', 'X', 'C' }

-- Invoke hints - Ctrl-Opt-Cmd-O {{{

--hs.hotkey.bind(hyper, '.', hs.hints.windowHints)
hs.hotkey.bind(hyper, 'o', nil, function()
  hs.hints.windowHints()
end)

-- Vim-like window navigation - Ctrl-Opt-Cmd-{hljk} {{{

hs.hotkey.bind(hyper, 'h', function() if hs.window.focusedWindow() then hs.window.focusedWindow():focusWindowWest()  end end)
hs.hotkey.bind(hyper, 'l', function() if hs.window.focusedWindow() then hs.window.focusedWindow():focusWindowEast()  end end)
hs.hotkey.bind(hyper, 'j', function() if hs.window.focusedWindow() then hs.window.focusedWindow():focusWindowSouth() end end)
hs.hotkey.bind(hyper, 'k', function() if hs.window.focusedWindow() then hs.window.focusedWindow():focusWindowNorth() end end)

-- Fonts
hs.hints.fontName           = 'Helvetica-Bold'
hs.hints.fontSize           = 22
hs.hints.showTitleThresh    = 0

local hotkey = require "hs.hotkey"
local grid = require "hs.grid"

grid.MARGINX = 10
grid.MARGINY = 10
grid.GRIDHEIGHT = 3
grid.GRIDWIDTH = 7

hotkey.bind(hyper,      '=', function() hs.grid.adjustWidth(1)   end)
hotkey.bind(hyper,      '-', function() hs.grid.adjustWidth(-1)  end)
hotkey.bind(hyperShift, '=', function() hs.grid.adjustHeight(1)  end)
hotkey.bind(hyperShift, '-', function() hs.grid.adjustHeight(-1) end)

--Move windows
hotkey.bind(modkey, 'DOWN', grid.pushWindowDown)
hotkey.bind(modkey, 'UP', grid.pushWindowUp)
hotkey.bind(modkey, 'LEFT', grid.pushWindowLeft)
hotkey.bind(modkey, 'RIGHT', grid.pushWindowRight)

--Move windows slightly
hotkey.bind(hyperShift, 'DOWN', grid.pushWindowDown)
hotkey.bind(hyperShift, 'UP', grid.pushWindowUp)
hotkey.bind(hyperShift, 'LEFT', grid.pushWindowLeft)
hotkey.bind(hyperShift, 'RIGHT', grid.pushWindowRight)


--resize windows
hotkey.bind(hyper, 'UP', grid.resizeWindowShorter)
hotkey.bind(hyper, 'DOWN', grid.resizeWindowTaller)
hotkey.bind(hyper, 'RIGHT', grid.resizeWindowWider)
hotkey.bind(hyper, 'LEFT', grid.resizeWindowThinner)

hotkey.bind(hyper, 'M', hs.grid.maximizeWindow)
hotkey.bind(hyper, 'F', function() hs.window.focusedWindow():toggleFullScreen() end)
hotkey.bind(hyper, 'N', hs.grid.pushWindowNextScreen)
hotkey.bind(hyper, 'P', hs.grid.pushWindowPrevScreen)



