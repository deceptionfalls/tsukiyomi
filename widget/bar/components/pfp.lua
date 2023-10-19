local wibox      = require("wibox")
local beautiful  = require("beautiful")
local gears      = require("gears")

local dpi       = beautiful.xresources.apply_dpi
local helpers   = require("helpers")
local user      = require('user')

return function()

  local pfp = wibox.widget {
      widget        = wibox.widget.imagebox,
      image         = user.avatar,
      clip_shape    = user.style == "rounded" and gears.shape.circle or gears.shape.rectangle,
      resize        = true,
      valign        = "center",
      halign        = "center",
      forced_height = dpi(10),
  }

  helpers.hoverCursor(pfp)

  return pfp
end
