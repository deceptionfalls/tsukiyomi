local wibox       = require("wibox")
local awful       = require("awful")
local beautiful   = require("beautiful")
local gears       = require("gears")

local profile     = require("widget.control_center.components.profile")

local dpi         = beautiful.xresources.apply_dpi
local helpers     = require("helpers")
local user        = require('user')

screen.connect_signal("request::desktop_decoration", function(s)
  s.control_center = wibox({
    shape     = helpers.rrect(10),
    width     = dpi(400),
    height    = dpi(600),
    bg        = beautiful.bg_dark,
    ontop     = false,
    visible   = true,
  })

  s.control_center:setup {
        {
            {
                {
                    profile,
                    nil,
                    layout = wibox.layout.align.horizontal
                },
                -- sliders,
                -- song,
                -- services,
                layout = wibox.layout.fixed.vertical,
                spacing = dpi(24)
            },
            widget = wibox.container.margin,
            margins = dpi(20)
        },
        {
            -- statusline,
            margins = {left = dpi(20), right = dpi(20), bottom = dpi(0)},
            widget = wibox.container.margin,
        },
        layout = wibox.layout.fixed.vertical,
    }
end)
