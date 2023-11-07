local wibox       = require("wibox")
local awful       = require("awful")
local beautiful   = require("beautiful")
local gears       = require("gears")

local helpers     = require("helpers")
local user        = require('user')

return function()

  local pfp = wibox.widget {
      widget        = wibox.widget.imagebox,
      image         = user.avatar,
      clip_shape    = user.style == "rounded" and gears.shape.circle or user.style == "semi-rounded" and helpers.rrect(10) or gears.shape.rectangle,
      resize        = true,
      valign        = "center",
      halign        = "center",
      spacing       = user.spacing,
      buttons       = {
        awful.button({}, 1, function()
          awesome.emit_signal("controlcenter::toggle")
        end)
      }
  }

  helpers.hoverCursor(pfp)

  return pfp
end
