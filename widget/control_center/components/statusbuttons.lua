local awful        = require("awful")
local wibox        = require("wibox")
local beautiful    = require("beautiful")

local dpi          = beautiful.xresources.apply_dpi
local helpers      = require("helpers")
local user         = require("user")

-- Function that creates a button based on given parameters, this is here so
-- we don't need to make a separate widget for every button
-- original code is from Chadcat7
local createButton = function(signal, icon, name, labelConnected, labelDisconnected)
  local widget = wibox.widget {
    {
      {
        {
          {
            markup        = icon,
            id            = "icon",
            font          = user.font .. "22",
            forced_width  = dpi(30),
            widget        = wibox.widget.textbox,
          },
          {
            {
              markup = name,
              id     = "name",
              font   = beautiful.font .. "Bold ",
              widget = wibox.widget.textbox,
            },
            {
              markup = labelConnected,
              id     = "label",
              font   = beautiful.font,
              widget = wibox.widget.textbox,
            },
            layout = wibox.layout.fixed.vertical,
            spacing = 0
          },
          layout = wibox.layout.fixed.horizontal,
          spacing = dpi(10),
        },
        layout = wibox.layout.align.horizontal,
      },
      widget  = wibox.container.margin,
      margins = { top = dpi(10), bottom = dpi(10), left = dpi(20), right = dpi(20) }
    },
    id = "back",
    bg = beautiful.accent,
    shape = helpers.rrect(15),
    widget = wibox.container.background,
    buttons = { awful.button({}, 1, function()
      awesome.emit_signal(signal .. "::toggle")
    end) }
  }
  awesome.connect_signal('signal::' .. signal, function(status)
  if status then
      widget:get_children_by_id("back")[1].bg      = beautiful.accent
      widget:get_children_by_id("name")[1].markup  = helpers.colorizeText(name, beautiful.bg_dark)
      widget:get_children_by_id("icon")[1].markup  = helpers.colorizeText(icon, beautiful.bg_dark)
      widget:get_children_by_id("label")[1].markup = helpers.colorizeText(labelConnected, beautiful.bg_dark)
    else
      widget:get_children_by_id("back")[1].bg      = beautiful.bg_normal
      widget:get_children_by_id("name")[1].markup  = helpers.colorizeText(name, beautiful.mid_normal)
      widget:get_children_by_id("icon")[1].markup  = helpers.colorizeText(icon, beautiful.mid_normal)
      widget:get_children_by_id("label")[1].markup = helpers.colorizeText(labelDisconnected, beautiful.mid_normal)
    end
  end)

  helpers.hoverCursor(widget)
  return widget
end

return function ()
  local widget = wibox.widget {
    {
      createButton("network", "󰤨", "Wi-fi", "On", "Off"),
      createButton("bluetooth", "󰂯", "Bluetooth", "On", "Off"),
      spacing = dpi(user.spacing),
      layout = wibox.layout.flex.horizontal
    },
    {
      createButton("compositor", "", "Compositor", "On", "Off"),
      createButton("caffeine", "󰅶", "Caffeine", "On", "Off"),
      spacing = dpi(user.spacing),
      layout = wibox.layout.flex.horizontal
    },
    layout = wibox.layout.fixed.vertical,
    spacing = dpi(user.spacing)
  }

  return widget
end
