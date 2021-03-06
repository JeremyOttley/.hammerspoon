# Hammerspoon Configuration
-Workstation:

  -Release version 0.9.46
  
  -https://github.com/Hammerspoon/hammerspoon/releases/tag/0.9.46

## Usage

You should definitely check out `init.lua` for the full "how to use" experience. That's where
all of the usage is defined, after all. For a brief breakdown though, here's what does what:

### "hyper" refers to pressing <kbd>⌘ + ⌥ + ⌃ </kbd> at once.
### "hyperShift" refers to pressing <kbd>⌘ + ⌥ + ⇧ </kbd> at once.

| Key Combination                 | Description                                                                                            |
| ------------------------------- | ------------------------------------------------------------------------------------------------------ |
| hyper + <kbd>;</kbd>             | Snaps the focused window to the grid.                                                                  |
| hyper + <kbd>'</kbd>             | Snaps *all* visible windows to the grid.                                                               |
| hyper + <kbd>=</kbd>             | Adds a column to the width of the grid.                                                                |
| hyper + <kbd>-</kbd>             | Removes a column from the width of the grid.                                                           |
| hyperShift + <kbd>=</kbd>        | Adds a row to the height of the grid.                                                                  |
| hyperShift + <kbd>-</kbd>        | Removes a row from the height of the grid.                                                             |
| hyperShift + <kbd>←</kbd>        | Focuses on the window to the left of the current window.                                               |
| hyperShift + <kbd>→</kbd>        | Focuses on the window to the right of the current window.                                              |
| hyperShift + <kbd>↑</kbd>        | Focuses on the window above the current window.                                                        |
| hyperShift + <kbd>↓</kbd>        | Focuses on the window below the current window.                                                        |
| hyper + <kbd>M</kbd>             | Maximize the current window.                                                                           |
| hyper + <kbd>F</kbd>             | Make the current window fullscreen.                                                                    |
| hyperShift + <kbd>F</kbd>        | Make the current window *not* fullscreen.                                                              |
| hyper + <kbd>N</kbd>             | Pushes the current window to the next monitor.                                                         |
| hyper + <kbd>P</kbd>             | Pushes the current window to the previous monitor.                                                     |
| hyper + <kbd>U</kbd>             | Makes the current window taller. Only works if there is room for the window to get bigger downward.    |
| hyper + <kbd>O</kbd>             | Makes the current window wider. Only works if there is room for the window to get bigger to the right. |
| hyper + <kbd>I</kbd>             | Makes the window thinner, from right to left.                                                          |
| hyper + <kbd>Y</kbd>             | Makes the window shorter, from bottom to top.                                                          |
| hyperShift + <kbd>spacebar</kbd> | Display currently playing song in Spotify.                                                             |
| hyperShift + <kbd>P</kbd>        | Start playing Spotify.                                                                                 |
| hyperShift + <kbd>O</kbd>        | Pause Spotify.                                                                                         |
| hyperShift + <kbd>N</kbd>        | Skip to next song on Spotify.                                                                          |
| hyperShift + <kbd>I</kbd>        | Skip to previous song on Spotify.                                                                      |
| hyperShift + <kbd>]</kbd>        | Increase volume by increment of 5                                                                      |
| hyperShift + <kbd>[</kbd>        | Decrease volume by increment of 5                                                                      |
| hyperShift + <kbd>T</kbd>        | Shows the current date and time.                                                                       |
