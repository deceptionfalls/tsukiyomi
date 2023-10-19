local gears     = require('gears')
local wibox     = require("wibox")
local beautiful = require("beautiful")
local helpers   = require("helpers")
local dpi       = beautiful.xresources.apply_dpi

local user      = require("user")

-- Stolen from chadcat7
-- https://github.com/chadcat7/crystal/tree/the-awesome-config

-- le batterie
local battery   = wibox.widget {
  id            = "battery",
  widget        = wibox.widget.progressbar,
  max_value     = 100,
  forced_width  = 70,
  forced_height = 90,
  shape         = user.style == "rounded" and helpers.rrect(30) or gears.shape.rectangle,
}

-- le batterie widgetté
local batstatus = wibox.widget {
  {
    {
      {
        {
          battery,
          {
            font   = user.font .. "16",
            markup = helpers.colorizeText("󱐋", beautiful.bg_dark),
            widget = wibox.widget.textbox,
            valign = "center",
            align  = "center"
          },
          layout = wibox.layout.stack
        },
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(15)
      },
      margins = dpi(0),
      widget = wibox.container.margin
    },
    layout = wibox.layout.stack
  },
  bg     = beautiful.bg_dark,
  widget = wibox.container.background,
  shape  = user.style == "rounded" and helpers.rrect(2) or gears.shape.rectangle,
}

awesome.connect_signal("signal::battery", function(value, state)
  local b = battery
  b.state = state
  b.value = value
  if state then
    b.color = beautiful.blue -- Set the color to blue for charging state
    b.background_color = beautiful.blue .. '80'
  elseif value < 18 then
    b.color = beautiful.red
    b.background_color = beautiful.red .. '80'
  elseif value < 30 then
    b.color = beautiful.yellow
    b.background_color = beautiful.yellow .. '80'
  else
    b.color = beautiful.green
    b.background_color = beautiful.green .. '80'
  end
end)

return batstatus
