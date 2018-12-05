-- Hammerspoon Hints

hs.hints.style = 'vimperator'
hs.hints.hintChars = { 'A', 'S', 'D', 'F', 'J', 'K', 'L', 'Q', 'W', 'E', 'R', 'Z', 'X', 'C' }

-- Invoke hints - Ctrl-Opt-Cmd-O {{{

hs.hotkey.bind(coc, 'o', nil, function()
  hs.hints.windowHints()
end)

-- Vim-like window navigation - Ctrl-Opt-Cmd-{hljk} {{{

hs.hotkey.bind(coc, 'h', function() if hs.window.focusedWindow() then hs.window.focusedWindow():focusWindowWest()  end end)
hs.hotkey.bind(coc, 'l', function() if hs.window.focusedWindow() then hs.window.focusedWindow():focusWindowEast()  end end)
hs.hotkey.bind(coc, 'j', function() if hs.window.focusedWindow() then hs.window.focusedWindow():focusWindowSouth() end end)
hs.hotkey.bind(coc, 'k', function() if hs.window.focusedWindow() then hs.window.focusedWindow():focusWindowNorth() end end)

-- Fonts
hs.hints.fontName           = 'Helvetica-Bold'
hs.hints.fontSize           = 22
hs.hints.showTitleThresh    = 0
