-- Welcome Message
--local alert_sound = hs.sound.getByFile("alert.wav")
--alert_sound:play() 

-- pomodoro
pomo = require('utils/cherry')

-- App vars
--local browser   = hs.appfinder.appFromName("Google Chrome")
--local term      = hs.appfinder.appFromName("xterm-256color")
--local bbedit    = hs.appfinder.appFromName("BBEdit")
--local outlook   = hs.appfinder.appFromName("Outlook")
--local finder    = hs.appfinder.appFromName("Finder")
--local slack     = hs.appfinder.appFromName("Slack")

-- Set window animation off. It's much smoother.
hs.window.animationDuration = 0

-- Remove window shadows
hs.window.setShadows(false)

--hs.hotkey.bind(hyper, 'D', function() hs.alert.show(os.date("%A %b %d, %Y - %I:%M%p"), 4) end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.alert.show("Hello World!")
end)

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
--do I need this alert?
hs.alert.show("Hammerspoon ready!", 3)
--hs.sound.getByFile("alert.wav"):play()

-- itunes
--hs.itunes.pause()


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
  
  --- quick open applications
  hs.hotkey.bind({"alt"}, "pad1", open("Finder"))
  hs.hotkey.bind({"alt"}, "pad2", open("xterm-256color"))
  hs.hotkey.bind({"alt"}, "pad3", open("BBEdit"))
  hs.hotkey.bind({"alt"}, "pad4", open("iTunes"))
  hs.hotkey.bind({"alt"}, "o", open("/Applications/Outlook"))

-- Determine all essential folders
-- Map them to letters instead of numbers for now

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

-- quick open new finder window
hs.hotkey.bind({"ctrl"}, 'F', function()
      finder = hs.appfinder.appFromName("Finder")
      finder:selectMenuItem({"File","New Finder Window"})
      finder:activate()
      end)

-- Welcome Message
--local alert_sound = hs.sound.getByFile("alert.wav")
--alert_sound:play() 

pomo = require('utils/pomo')

-- App vars
--local browser   = hs.appfinder.appFromName("Google Chrome")
--local term      = hs.appfinder.appFromName("xterm-256color")
--local bbedit    = hs.appfinder.appFromName("BBEdit")
--local outlook   = hs.appfinder.appFromName("Outlook")
--local finder    = hs.appfinder.appFromName("Finder")
--local slack     = hs.appfinder.appFromName("Slack")

-- Set window animation off. It's much smoother.
hs.window.animationDuration = 0

-- Remove window shadows
hs.window.setShadows(true)

--hs.hotkey.bind(hyper, 'D', function() hs.alert.show(os.date("%A %b %d, %Y - %I:%M%p"), 4) end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.alert.show("Hello World!")
end)

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
--do I need this alert?
hs.alert.show("Hammerspoon ready!", 3)
--hs.sound.getByFile("alert.wav"):play()


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
  
  --- quick open applications
  hs.hotkey.bind({"alt"}, "pad1", open("Finder"))
  hs.hotkey.bind({"alt"}, "pad2", open("xterm-256color"))
  hs.hotkey.bind({"alt"}, "pad3", open("BBEdit"))
  hs.hotkey.bind({"alt"}, "pad4", open("iTunes"))
  hs.hotkey.bind({"alt"}, "o", open("/Applications/Outlook"))

-- Determine all essential folders
-- Map them to letters instead of numbers for now

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
