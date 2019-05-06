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
--  {{modkey}, "F"},
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

local grid = hs.grid

grid.GRIDWIDTH  = 12
grid.GRIDHEIGHT = 12
grid.MARGINX    = 0
grid.MARGINY    = 0

--
-- [[ Commands ]] --
--

hs.hotkey.bind(hyper, 'M', grid.maximizeWindow)

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
end)
