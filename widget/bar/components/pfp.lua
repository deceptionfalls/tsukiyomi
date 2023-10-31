local wibox      = require("wibox")
local beautiful  = require("beautiful")
local gears      = require("gears")

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
      spacing       = user.spacing
  }

  helpers.hoverCursor(pfp)

  return pfp
end
