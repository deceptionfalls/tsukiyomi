local wibox             = require("wibox")
local awful             = require("awful")
local beautiful         = require("beautiful")
local gears             = require("gears")

local dpi               = beautiful.xresources.apply_dpi
local helpers           = require("helpers")
local user              = require("user")

local profile           = require("widget.control_center.components.profile")
local statusbuttons     = require("widget.control_center.components.statusbuttons")

screen.connect_signal("request::desktop_decoration", function(s)
  s.control_center = wibox ({
    shape     = user.style == "rounded" and helpers.rrect(15) or user.style == "semi-rounded" and helpers.rrect(10),
    width     = dpi(450),
    height    = dpi(700),
    bg        = beautiful.bg_dark,
    ontop     = true,
    visible   = false,
  })

  s.control_center:setup({
    {
      profile(s),
      margins = { top = dpi(20), bottom = dpi(0), left = dpi(20), right = dpi(20) },
      widget = wibox.container.margin,
    },
    {
      statusbuttons(s),
      margins = dpi(20),
      widget = wibox.container.margin,
    },
    layout = wibox.layout.fixed.vertical,
  })

  awesome.connect_signal('controlcenter::toggle', function()
    s.control_center.visible = not s.control_center.visible
  end)

  awful.placement.right(s.control_center, { honor_padding = true, margins = { top = dpi(50) } })
end)

