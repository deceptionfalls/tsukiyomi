local awful      = require("awful")
local gears      = require("gears")
local dpi        = require('beautiful').xresources.apply_dpi
local gfs        = require("gears.filesystem")

local user       = require('user')
local helpers    = require('helpers')
local color      = require('theme.colorscheme')

local path       = gfs.get_themes_dir()
local icon_path  = gfs.get_configuration_dir() .. 'assets/'

local _T = {}

_T.fontsize            = user.fontsize
_T.font                = user.font
_T.font_mono           = user.font_mono

-- colors
_T.red                 = color.red
_T.orange              = color.orange
_T.yellow              = color.yellow
_T.green               = color.green
_T.cyan                = color.cyan
_T.lightblue           = color.lightblue
_T.blue                = color.blue
_T.purple              = color.purple
_T.magenta             = color.magenta

-- function to get the accent color from the user file
local function getAccentColor()
    local accentColor = nil

    if user.accent == "red" then
        accentColor = color.red
    elseif user.accent == "orange" then
        accentColor = color.orange
    elseif user.accent == "yellow" then
        accentColor = color.yellow
    elseif user.accent == "green" then
        accentColor = color.green
    elseif user.accent == "cyan" then
        accentColor = color.cyan
    elseif user.accent == "lightblue" then
        accentColor = color.lightblue
    elseif user.accent == "blue" then
        accentColor = color.blue
    elseif user.accent == "purple" then
        accentColor = color.purple
    elseif user.accent == "magenta" then
        accentColor = color.magenta
    else
      -- default
        accentColor = color.purple
    end

    return accentColor
end

_T.accent              = getAccentColor()

_T.bg_dark             = color.bg_dark
_T.bg_normal           = color.bg_normal
_T.bg_light            = color.bg_light
_T.mid_dark            = color.mid_dark
_T.mid_normal          = color.mid_normal
_T.mid_light           = color.mid_light
_T.fg_normal           = color.fg_normal

_T.transparent         = '#00000000'

-- AWM values
_T.useless_gap         = dpi(user.inner_gaps)
_T.border_width        = dpi(user.border)
_T.border_color_normal = color.bg_dark
_T.border_color_active = _T.accent

_T.menu_height         = dpi(15)
_T.menu_width          = dpi(100)

_T.layout_tile          = gears.color.recolor_image(path .. "default/layouts/tilew.png", _T.fg_normal)
_T.layout_max           = gears.color.recolor_image(path .. "default/layouts/max.png", _T.fg_normal)
_T.layout_floating      = gears.color.recolor_image(path .. "default/layouts/floatingw.png", _T.fg_normal)

_T.cookie               = gears.surface.load(icon_path .. "cookie3.svg")
_T.moon                 = gears.surface.load(icon_path .. "moon.svg")
_T.cookie_small         = gears.color.recolor_image(icon_path .. "cookie-small.svg", color.fg_normal)
_T.volumeicon           = gears.color.recolor_image(icon_path .. "volume.svg", color.fg_normal)
_T.volumeofficon        = gears.color.recolor_image(icon_path .. "volume-off.svg", color.fg_normal)
_T.bluetoothicon        = gears.color.recolor_image(icon_path .. "bluetooth.svg", color.fg_normal)
_T.bluetoothofficon     = gears.color.recolor_image(icon_path .. "bluetooth-off.svg", color.fg_normal)
_T.wifiicon             = gears.color.recolor_image(icon_path .. "wifi.svg", color.fg_normal)
_T.wifiofficon          = gears.color.recolor_image(icon_path .. "wifi-off.svg", color.fg_normal)

-- Taglist
_T.taglist_font         = _T.font
_T.taglist_bg_focus     = _T.accent
_T.taglist_bg_occupied  = color.mid_dark
_T.taglist_bg_empty     = color.bg_light
_T.taglist_bg_urgent    = color.yellow

-- Tasklist
_T.tasklist_bg_focus    = color.bg_light
_T.tasklist_bg_normal   = color.bg_normal

-- Titlebar
_T.titlebar_bg_normal   = color.bg_normal
_T.titlebar_bg_focus    = color.bg_light
_T.titlebar_bg_urgent   = color.bg_normal

_T.titlebar_fg_normal   = color.mid_normal
_T.titlebar_fg_focus    = color.fg_normal
_T.titlebar_fg_urgent   = color.red

-- Icons
_T.icon_theme           = user.icon_theme

-- Snap
_T.snap_border_width    = dpi(4)
_T.snap_border_radius   = dpi(4)
_T.snap_bg              = _T.accent
_T.snap_shape           = helpers.rrect(15)
_T.snapper_gap          = dpi(user.inner_gaps)

-- Systray
_T.systray_max_rows     = 1
_T.systray_icon_spacing = dpi(2)
_T.bg_systray           = color.bg_dark

-- Notifications
_T.notification_spacing = dpi(user.outer_gaps)

return _T
