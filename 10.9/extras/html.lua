function keyStrokes(str)
    return function()
        hs.eventtap.keyStrokes(str)
    end
end
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "I", keyStrokes("<italic>"))
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "B", keyStrokes("<em>"))