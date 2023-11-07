local wibox      = require("wibox")
local beautiful  = require("beautiful")
local gears      = require("gears")

local dpi       = beautiful.xresources.apply_dpi
local helpers   = require("helpers")
local user      = require('user')

return function ()
  local clock = {
      {
        {
          format = '<b>%I:%M</b>',
          valign = "center",
          halign = "center",
          widget = wibox.widget.textclock,
          font   = user.font .. "11"
        },
        left     = dpi(15),
        right    = dpi(15),
        bottom   = dpi(2),
        top      = dpi(2),
        widget   = wibox.container.margin
      },
      fg         = beautiful.fg_normal,
      bg         = beautiful.bg_normal,
      visible    = user.clock_vis,
      shape      = user.style == "rounded" and helpers.rrect(50) or user.style == "semi-rounded" and helpers.rrect(10) or gears.shape.rectangle,
      widget     = wibox.container.background,
  }

  local vbar_clock = {
    {
        {
            {
                format = '<b>%I</b>',
                font   = user.font .. user.fontsize,
                halign = "center",
                widget = wibox.widget.textclock
            },
            {
                format = '<b>%M</b>',
                font   = user.font .. user.fontsize,
                halign = "center",
                widget = wibox.widget.textclock
            },
            layout  = wibox.layout.fixed.vertical
        },
        left     = dpi(2),
        right    = dpi(2),
        bottom   = dpi(9),
        top      = dpi(9),
        widget  = wibox.container.margin
    },
    fg      = beautiful.fg_normal,
    bg      = beautiful.bg_normal,
    shape   = user.style == "rounded" and helpers.rrect(50) or user.style == "semi-rounded" and helpers.rrect(10) or gears.shape.rectangle,
    widget  = wibox.container.background
  }

  if user.bar_type == "vertical" then
    return vbar_clock else
    return clock
  end
end
