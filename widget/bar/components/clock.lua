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
          font   = user.font .. user.fontsize,
        },
        left     = dpi(15),
        right    = dpi(15),
        bottom   = dpi(2),
        top      = dpi(2),
        widget   = wibox.container.margin
      },
      fg         = beautiful.fg_normal,
      bg         = beautiful.bg_normal,
      shape      = user.style == "rounded" and helpers.rrect(50) or gears.shape.rectangle,
      widget     = wibox.container.background
  }
  return clock
end
