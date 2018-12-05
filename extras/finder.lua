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
  hs.hotkey.bind({"alt"}, "W", open("WeChat"))
  hs.hotkey.bind({"alt"}, "C", open("Google Chrome"))
  hs.hotkey.bind({"alt"}, "T", open("iTerm"))
  hs.hotkey.bind({"alt"}, "X", open("Xcode"))
  hs.hotkey.bind({"alt"}, "S", open("Sublime Text"))
  hs.hotkey.bind({"alt"}, "V", open("Visual Studio Code"))
  hs.hotkey.bind({"alt"}, "I", open("IntelliJ IDEA CE"))
  hs.hotkey.bind({"alt"}, "N", open("NeteaseMusic")) -- netease
  hs.hotkey.bind({"alt"}, "M", open("Spark")) -- mail
  hs.hotkey.bind({"alt"}, "H", open("Things3"))

