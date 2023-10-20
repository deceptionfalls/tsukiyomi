local wibox       = require("wibox")
local awful       = require("awful")
local beautiful   = require("beautiful")
local gears       = require("gears")

local dpi         = beautiful.xresources.apply_dpi
local helpers     = require("helpers")
local user        = require('user')

return function ()
  local function status_widget(button)
      local status = wibox.widget {
          {
            {
              id      = "image_role",
              align   = "center",
              widget  = wibox.widget.imagebox
            },
            valign  = "center",
            halign  = "center",
            widget  = wibox.container.place
          },
          forced_width = dpi(16),
          widget  = wibox.container.place,
          buttons = {
              awful.button({}, 1, button)
          },
          set_image = function(self, content)
              self:get_children_by_id('image_role')[1].image = content
          end
      }
      return status
  end

  bar_btn_sound = status_widget(function() awesome.emit_signal("volume::mute") end)
  bar_btn_net   = status_widget(function() awesome.emit_signal("network::toggle") end)
  bar_btn_blue  = status_widget(function() awesome.emit_signal("bluetooth::toggle") end)

  helpers.hoverCursor(bar_btn_sound)
  helpers.hoverCursor(bar_btn_net)
  helpers.hoverCursor(bar_btn_blue)

  local buttons = wibox.widget {
    {
      {
        bar_btn_sound,
        bar_btn_net,
        {
          bar_btn_blue,
          widget = wibox.widget,
          layout = user.bar_type == "vertical" and wibox.layout.fixed.vertical or wibox.layout.fixed.horizontal,
          visible = user.bluetooth_enabled
        },
        spacing = dpi(user.spacing / 2),
        margins = dpi(10),
        layout = user.bar_type == "vertical" and wibox.layout.fixed.vertical or wibox.layout.fixed.horizontal
      },
      left   = dpi(9),
      right  = dpi(9),
      top    = user.bar_type == "vertical" and dpi(9) or dpi(0),
      bottom = user.bar_type == "vertical" and dpi(9) or dpi(0),
      widget = wibox.container.margin
    },
    bg = beautiful.bg_normal,
    shape = user.style == "rounded" and helpers.rrect(30) or gears.shape.rectangle,
    widget = wibox.container.background
  }

  -- Sound signal
  awesome.connect_signal("signal::volume", function(volume, muted)
      if muted then bar_btn_sound.image = beautiful.volumeofficon else bar_btn_sound.image = beautiful.volumeicon end
  end)
  -- Networking signals
  awesome.connect_signal("signal::bluetooth", function(is_enabled)
      if is_enabled then bar_btn_blue.image = beautiful.bluetoothicon else bar_btn_blue.image = beautiful.bluetoothofficon end
  end)
  -- Networking signals
  awesome.connect_signal("signal::network", function(is_enabled)
      bar_btn_net.image = is_enabled and beautiful.wifiicon or beautiful.wifiofficon
  end)

  return buttons

end
