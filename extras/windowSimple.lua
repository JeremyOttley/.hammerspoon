local hotkey = require "hs.hotkey"
local grid = require "hs.grid"

grid.MARGINX = 10
grid.MARGINY = 10
grid.GRIDHEIGHT = 3
grid.GRIDWIDTH = 7

local mash = {"cmd", "alt", "ctrl"}
local mashshift = {"cmd", "alt", "ctrl", "shift"}
local slightmash = {"cmd", "ctrl"}


--Move windows
hotkey.bind(mash, 'DOWN', grid.pushWindowDown)
hotkey.bind(mash, 'UP', grid.pushWindowUp)
hotkey.bind(mash, 'LEFT', grid.pushWindowLeft)
hotkey.bind(mash, 'RIGHT', grid.pushWindowRight)

--Move windows slightly
hotkey.bind(slightmash, 'DOWN', grid.pushWindowDown)
hotkey.bind(slightmash, 'UP', grid.pushWindowUp)
hotkey.bind(slightmash, 'LEFT', grid.pushWindowLeft)
hotkey.bind(slightmash, 'RIGHT', grid.pushWindowRight)


--resize windows
hotkey.bind(mashshift, 'UP', grid.resizeWindowShorter)
hotkey.bind(mashshift, 'DOWN', grid.resizeWindowTaller)
hotkey.bind(mashshift, 'RIGHT', grid.resizeWindowWider)
hotkey.bind(mashshift, 'LEFT', grid.resizeWindowThinner)
