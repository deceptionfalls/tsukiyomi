local wibox       = require("wibox")
local awful       = require("awful")
local beautiful   = require("beautiful")
local gears       = require("gears")

local dpi         = beautiful.xresources.apply_dpi
local helpers     = require("helpers")
local user        = require("user")

local profile     = require("widget.control_center.components.profile")
local wifi_btn    = require("widget.control_center.components.wifi_btn")

screen.connect_signal("request::desktop_decoration", function(s)
  s.control_center = wibox ({
    shape     = user.style == "rounded" and helpers.rrect(15) or user.style == "semi-rounded" and helpers.rrect(10),
    width     = dpi(900),
    height    = dpi(600),
    bg        = beautiful.bg_dark,
    ontop     = true,
    visible   = false,
    x         = 250,
    y         = 50
  })

  s.control_center:setup({
    {
      profile(s),
      margins = dpi(20),
      widget = wibox.container.margin,
    },
    layout = wibox.layout.fixed.vertical,
  })

  awesome.connect_signal('controlcenter::toggle', function()
    s.control_center.visible = not s.control_center.visible
  end)
end)
