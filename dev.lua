-- Welcome Message
hs.alert.show("Hammerspoon ready!", 3)
--local alert_sound = hs.sound.getByFile("alert.wav")
--alert_sound:play() 

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



-- Hyper key 
hyper = {'⌘', '⌥', 'ctrl'}

-- Shift Hyper
shift_hyper = {'⌘', '⌥', '⇧', 'ctrl'}

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

-- App vars
--local browser   = hs.appfinder.appFromName("Google Chrome")
--local term      = hs.appfinder.appFromName("xterm-256color")
--local bbedit    = hs.appfinder.appFromName("BBEdit")
--local outlook   = hs.appfinder.appFromName("Outlook")
--local finder    = hs.appfinder.appFromName("Finder")
--local slack     = hs.appfinder.appFromName("Slack")

-- [[ Window Movement ]] --

-- modkeys/chords
modkey = {"cmd","alt"}
local hyper = {'ctrl', 'alt', 'cmd'}
local hyperShift = {'ctrl', 'alt', 'cmd', 'shift'}

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

-- open
function open(name)
    return function()
        hs.application.launchOrFocus(name)
        if name == 'Finder' then
            hs.appfinder.appFromName(name):activate()
        end
    end
  end

-- Set window animation off. It's much smoother.
hs.window.animationDuration = 0

-- Remove window shadows
hs.window.setShadows(true)

-- open key folders with ctrl + 1,2,3,
function directoryLaunchKeyRemap(mods, key, dir)
    local mods = mods or {}
    hs.hotkey.bind(mods, key, function()
        local shell_command = "open " .. dir
        hs.execute(shell_command)
    end)
end

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

-- does this work?
--tabs.enableForApp("Adobe Acrobat Pro")
