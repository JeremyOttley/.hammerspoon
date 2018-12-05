-- Welcome Message
local alert_sound = hs.sound.getByFile("alert.wav")
--local tink_sound  = hs.sound.getByName("Tink") -- Not actually used, just as a nice example.
                                               -- More sounds in /System/Library/Sounds

-- App vars
--local browser   = hs.appfinder.appFromName("Google Chrome")
--local term      = hs.appfinder.appFromName("xterm-256color")
--local bbedit    = hs.appfinder.appFromName("BBEdit")
--local outlook   = hs.appfinder.appFromName("Outlook")
--local finder    = hs.appfinder.appFromName("Finder")
--local slack     = hs.appfinder.appFromName("Slack")

alert_sound:play()
hs.alert.show("Hammerspoon, at your service.", 3)

-- Set window animation off. It's much smoother.
hs.window.animationDuration = 0

-- Remove window shadows
hs.window.setShadows(false)

--hs.hotkey.bind(hyper, 'D', function() hs.alert.show(os.date("%A %b %d, %Y - %I:%M%p"), 4) end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.alert.show("Hello World!")
end)

-- Reload on config change
-- consider switching to spoon later

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
--hs.alert.show("Config loaded")

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

-- open key folders with ctrl + 1,2,3,
--function directoryLaunchKeyRemap(mods, key, dir)
--    local mods = mods or {}
--    hs.hotkey.bind(mods, key, function()
--        local shell_command = "open " .. dir
--        hs.execute(shell_command)
--    end)
--end

--directoryLaunchKeyRemap({"ctrl"}, "1", "/Applications") 

--[[ UTILS ]]--

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
  hs.hotkey.bind({"alt"}, "E", open("Finder"))
  --hs.hotkey.bind({"alt"}, "W", open("WeChat"))
  --hs.hotkey.bind({"alt"}, "C", open("Google Chrome"))
  hs.hotkey.bind({"alt"}, "T", open("xterm-256color"))
  --hs.hotkey.bind({"alt"}, "X", open("Xcode"))
  --hs.hotkey.bind({"alt"}, "S", open("Sublime Text"))
  --hs.hotkey.bind({"alt"}, "V", open("Visual Studio Code"))
  hs.hotkey.bind({"alt"}, "I", open("BBEdit"))
  hs.hotkey.bind({"alt"}, "N", open("iTunes"))
  hs.hotkey.bind({"alt"}, "M", open("Outlook"))
  hs.hotkey.bind({"alt"}, "H", open("Things3"))
