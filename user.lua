local awful = require('awful')
local home  = os.getenv('HOME') .. '/'

local _U = {}

-- Functionality
---------------------------------------------
_U.modkey       = "Mod4" -- Windows/Super key
_U.modkey2      = "Mod1" -- Alt key

-- Turn on/off signals
_U.bluetooth_enabled  = true
_U.battery_enabled    = true

-- Use desktop icons if enabled
-- WARNING: this only works with the floating layout, it will break everything else
-- requires Nemo as your file manager, plus some setup regarding Nemo: learn more about it on
-- https://star.is-a.dev/blog/icons
_U.desktop_icon = false

-- Apps
_U.terminal     = "st"
_U.files        = "thunar"
_U.browser      = "firefox"
_U.chatapp      = "discord"
_U.files_cli    = "ranger"
_U.vol_cli      = "alsamixer"

_U.layouts      = {
  awful.layout.suit.tile,
  -- awful.layout.suit.floating,
  -- awful.layout.suit.max,
  -- awful.layout.suit.tile.left,
  -- awful.layout.suit.tile.bottom
  -- awful.layout.suit.tile.top
  -- awful.layout.suit.fair
  -- awful.layout.suit.fair.horizontal
  -- awful.layout.suit.spiral
  -- awful.layout.suit.spiral.dwindle
  -- awful.layout.suit.max.fullscreen
  -- awful.layout.suit.magnifier
  -- awful.layout.suit.corner.nw
}

_U.tags         = { '1', '2', '3', '4' }

-- Positioning
---------------------------------------------

-- Position of titlebar
_U.titlebar_pos = "top"

-- Type of bar:
-- horizontal, vertical
_U.bar_type     = "vertical"

-- Position of the bar
_U.bar_pos      = "left"

-- Position of notifications
_U.notification_pos = "top_right"

-- Visual elements
---------------------------------------------

-- Border width
_U.border       = 0

-- Spacing between UI elements
_U.spacing      = 8

-- Inner and outer gaps
_U.inner_gaps   = 5
_U.outer_gaps   = 10

-- Style of UI elements and windows:
-- sharp, rounded
_U.style        = "rounded"

-- Don't, looks bad, just don't
_U.transparent_bar = false

-- Toggle titlebars on/off
_U.titlebar     = false

-- Color and themes
---------------------------------------------

-- Available colorschemes:
-- biscuit_dark, sakura, oxocarbon
_U.colorscheme  = "biscuit_dark"

-- Dictates color of homeicon, active tag, active border, etc.
-- Available accent colors:
-- red, orange, yellow, green, cyan, lightblue, blue, magenta, purple
_U.accent       = "yellow"

-- Available icons:
-- cookie, cookie_small, moon
_U.icon         = "cookie_small"

-- TODO: add more icons that follow this rule
-- Style for the home icon:
-- normal, filled
_U.icon_style   = "filled"

-- Font config
-- the little space is for declaring a custom font size
_U.font         = "IBM Plex Sans" .. " "
_U.font_mono    = "IBM Plex Mono" .. " "
_U.fontsize     = "11"

-- Currently unused but will be once I figure out a dock
_U.icon_theme   = "Papirus"

-- Image related
_U.avatar       = home .. '/Downloads/pfp.png'
_U.wallpaper    = home .. '/Downloads/pexels-charles-parker-5845547_biscuit-dark_hald8_GaussianRBF_lum1_shape96_near16.png'

return _U
