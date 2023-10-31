local wibox       = require("wibox")
local awful       = require("awful")
local beautiful   = require("beautiful")
local gears       = require("gears")

local home        = require("widget.bar.components.home")
local pfp         = require("widget.bar.components.pfp")
local clock       = require("widget.bar.components.clock")
local tags        = require("widget.bar.components.taglist")
local tasks       = require("widget.bar.components.tasklist")
local layouts     = require("widget.bar.components.layoutbox")
local status      = require("widget.bar.components.status")
local battery     = require("widget.bar.components.battery")

local dpi         = beautiful.xresources.apply_dpi
local helpers     = require("helpers")
local user        = require('user')

screen.connect_signal("request::desktop_decoration", function(s)
    awful.tag(user.tags, s, awful.layout.layouts[1])

    local taglist_v = wibox.widget {
        {
            tags(s),
            margins = dpi(9),
            widget  = wibox.container.margin
        },
        bg      = beautiful.bg_normal,
        shape   = user.style == "rounded" and helpers.rrect(50) or gears.shape.rectangle,
        widget  = wibox.container.background
    }
    helpers.hoverCursor(taglist_v)

    local taglist = wibox.widget {
          {
            {
                tags(s),
                margins = dpi(9),
                widget  = wibox.container.margin,
            },
            bg          = beautiful.bg_normal,
            shape       = user.style == "rounded" and helpers.rrect(50) or gears.shape.rectangle,
            widget      = wibox.container.background
          },
          direction   = "east",
          widget      = wibox.container.rotate
        }
    helpers.hoverCursor(taglist)

-- le bar
 s.wibar    = awful.wibar {
      position       = user.bar_pos,
      screen         = s,
      height         = user.bar_type == "vertical" and dpi(750) or dpi(30),
      border_width   = dpi(10),
      border_color   = user.transparent_bar == true and beautiful.transparent or beautiful.bg_dark,
      bg             = user.transparent_bar == true and beautiful.transparent or beautiful.bg_dark,
      widget         = {
        {
          home(s),
          user.bar_type == "vertical" and taglist_v or taglist,
          tasks(s),
          spacing = dpi(user.spacing),
          layout = user.bar_type == "vertical" and wibox.layout.fixed.vertical or wibox.layout.fixed.horizontal
        },
          nil,
          expand = "none",
        {
          {
            battery,
            widget  = wibox.widget,
            layout  = wibox.layout.fixed.horizontal,
            visible = user.battery_enabled
          },
          status(s),
          clock(s),
          {
            {
                layouts(s),
                margins = dpi(7),
                widget  = wibox.container.margin
            },
            bg      = beautiful.bg_normal,
            shape   = user.style == "rounded" and helpers.rrect(30),
            widget  = wibox.container.background
          },
          pfp(s),
          spacing = dpi(user.spacing),
          layout  = user.bar_type == "vertical" and wibox.layout.fixed.vertical or wibox.layout.fixed.horizontal
        },
        layout  = user.bar_type == "vertical" and wibox.layout.align.vertical or wibox.layout.align.horizontal,
        right   = dpi(user.outer_gaps),
        left    = dpi(user.outer_gaps),
        bottom  = dpi(user.outer_gaps),
        top     = dpi(user.outer_gaps),
        widget  = wibox.container.margin
      }
    }

    -- apply le outer gaps
    local screen = awful.screen.focused()
    screen.padding = {
        right   = dpi(user.outer_gaps),
        left    = dpi(user.outer_gaps),
        bottom  = dpi(user.outer_gaps),
        top     = dpi(user.outer_gaps)
    }
end)
