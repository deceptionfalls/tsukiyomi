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

local taglist = wibox.widget {
      {
        {
            tags(s),
            margins = dpi(9),
            widget  = wibox.container.margin,
        },
        shape       = user.style == "rounded" and helpers.rrect(50) or gears.shape.rectangle,
        bg          = beautiful.bg_normal,
        widget      = wibox.container.background
      },
      direction   = "east",
      widget      = wibox.container.rotate
    }
helpers.hoverCursor(taglist)

-- le bar
 s.wibar    = awful.wibar {
      position       = "top",
      screen         = s,
      height         = dpi(30),
      border_width   = dpi(10),
      border_color   = beautiful.bg_dark,
      bg             = beautiful.bg_dark,
      widget         = {
        {
          home(s),
          taglist,
          spacing = dpi(user.spacing),
          layout = wibox.layout.fixed.horizontal
        },
        {
          tasks(s),
          align  = "center",
          widget = wibox.container.place
        },
        {
          battery,
          status(s),
          clock(s),
          {
            {
                layouts(s),
                margins = dpi(user.spacing),
                widget  = wibox.container.margin
            },
            bg      = beautiful.bg_normal,
            shape   = user.style == "rounded" and helpers.rrect(30),
            widget  = wibox.container.background
          },
          pfp(s),
          spacing = dpi(user.spacing),
          layout  = wibox.layout.fixed.horizontal
        },
        margins = 8,
        layout  = wibox.layout.align.horizontal,
        widget  = wibox.container.margin
      }
    }

end)
