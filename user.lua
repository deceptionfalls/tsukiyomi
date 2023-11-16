local awful = require('awful')
local home  = os.getenv('HOME') .. '/'

local _U = {}

---------------------------------------------
-- Functionality
---------------------------------------------
_U.modkey       = "Mod4" -- Windows/Super key
_U.modkey2      = "Mod1" -- Alt key

---------------------------------------------
-- Signals
---------------------------------------------

-- Turn on/off signals
_U.bluetooth_enabled  = true
_U.battery_enabled    = true

---------------------------------------------
-- Desktop Icons
---------------------------------------------

-- Use desktop icons if enabled
-- WARNING: this only works with the floating layout, it will break everything else
-- requires Nemo as your file manager, plus some setup regarding Nemo: learn more about it on
-- https://star.is-a.dev/blog/icons
_U.desktop_icon = true

---------------------------------------------
-- Apps
---------------------------------------------

-- Terminal and terminal command for scratchpads
_U.terminal     = "st"
_U.term_cmd     = "st -c "

-- GUI Apps
_U.browser      = os.getenv("BROWSER") or "firefox"
_U.editor       = os.getenv("EDITOR")  or "nvim"
_U.files        = "nemo"
_U.chatapp      = "discord"

-- CLI apps
_U.files_cli    = "ranger"

---------------------------------------------
-- Music
---------------------------------------------

-- Turn on/off music related decorations and signals
_U.music_enabled      = true

---------------------------------------------
-- Awesome related
---------------------------------------------

_U.layouts      = {
  -- awful.layout.suit.tile,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.max,
  awful.layout.suit.floating,
  -- awful.layout.suit.tile.left,
  -- awful.layout.suit.tile.bottom,
  -- awful.layout.suit.tile.top,
  -- awful.layout.suit.fair,
  -- awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
}

_U.tags         = { '1', '2', '3', '4', '5' }

---------------------------------------------
-- Titlebars
---------------------------------------------

-- Toggle titlebars on/off
_U.titlebar     = false

-- Position of titlebar
_U.titlebar_pos = "top"

-- Toggle visibility of titlebar icons
_U.titlebar_icons = true

---------------------------------------------
-- Bar
---------------------------------------------

-- Type of bar:
-- horizontal, vertical
_U.bar_type     = "horizontal"

-- Position of the bar:
-- bottom, top, left, right
_U.bar_pos      = "top"

-- Don't, looks bad, just don't
_U.transparent_bar = false

---------------------------------------------
-- Dock
---------------------------------------------

-- Toggle the dock on/off
_U.dock_enabled = false

---------------------------------------------
-- Notifications
---------------------------------------------

-- Position of notifications
_U.notification_pos = "top_right"

---------------------------------------------
-- Borders and gaps
---------------------------------------------

-- Border width
-- If titlebars are off, this will use the color of your accent color,
-- else it will use bg colors
_U.border       = 0

-- Spacing between UI elements
_U.spacing      = 8

-- Inner and outer gaps
_U.inner_gaps   = 3
_U.outer_gaps   = 15

---------------------------------------------
-- UI Style
---------------------------------------------

-- Style of UI elements and windows 
-- affects corner radius, visual style of the bar, etc
-- sharp, rounded, semi-rounded
_U.style        = "rounded"

---------------------------------------------
-- Color and themes
---------------------------------------------

-- Available colorschemes:
-- biscuit, sakura, oxocarbon, camellia, adwaita, latte, fullerene, stardew, solarized, chi-tsuki, nymph
_U.colorscheme   = "biscuit"

-- Dictates color of homeicon, active tag, active border, etc.
-- Available accent colors:
-- white, red, orange, yellow, green, cyan, lightblue, blue, magenta, purple
-- defaults to "white" if nil
_U.accent        = "green"

-- Available icons:
-- cookie, cookie_small, moon, star, awm
_U.icon          = "cookie_small"

-- Font config
-- the little space is for declaring a custom font size
_U.font          = "IBM Plex Sans" .. " "
_U.font_mono     = "IBM Plex Mono" .. " "
_U.fontsize      = "14"

-- Path to your icon theme
_U.icon_theme    = home .. ".icons/Colloid"

-- Image related
_U.avatar        = home .. 'Pictures/Anime/etc/5968c154f23d649bbddfa85f41e0df13.jpg'
_U.wallpaper     = home .. 'Wallpapers/walls-main/custom/42.jpg'

_U.screenshotdir = home .. 'Pictures/Screenshots/'

_U.username      = os.getenv("USER")

return _U
