local wibox       = require("wibox")
local awful       = require("awful")
local beautiful   = require("beautiful")

local helpers     = require("helpers")
local user        = require('user')

return function()
  local systray_btn = wibox.widget {
      {
          {
              text    = "󰅂",
              font    = user.font .. "16",
              align   = "center",
              widget  = wibox.widget.textbox,
          },
          direction   = user.bar_pos and "south" or "east",
          widget      = wibox.container.rotate
      },
      bg     = beautiful.bg_dark,
      shape  = helpers.rrect(),
      widget = wibox.container.background,
      buttons = {
          awful.button({}, 1, function()
              awesome.emit_signal("systray::toggle")
          end)
      }
  }
  helpers.hoverCursor(systray_btn)

  return systray_btn
end
