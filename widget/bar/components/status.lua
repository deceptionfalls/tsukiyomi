local wibox       = require("wibox")
local awful       = require("awful")
local beautiful   = require("beautiful")

local dpi         = beautiful.xresources.apply_dpi
local helpers     = require("helpers")
local user        = require("user")
local batstatus   = require("widget.bar.components.battery")

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
  bar_btn_bat   = status_widget()

  helpers.hoverCursor(bar_btn_sound)
  helpers.hoverCursor(bar_btn_net)
  helpers.hoverCursor(bar_btn_blue)
  -- helpers.hoverCursor(bar_btn_bat)

  local buttons = wibox.widget {
    {
      {
        bar_btn_bat,
        -- bar_btn_sound,
        bar_btn_net,
        {
          bar_btn_blue,
          widget  = wibox.widget,
          layout  = user.bar_type == "vertical" and wibox.layout.fixed.vertical or wibox.layout.fixed.horizontal,
          visible = user.bluetooth_enabled
        },
        spacing = dpi(user.spacing / 2),
        margins = dpi(10),
        layout  = user.bar_type == "vertical" and wibox.layout.fixed.vertical or wibox.layout.fixed.horizontal
      },
      left   = dpi(12),
      right  = dpi(9),
      top    = user.bar_type == "vertical" and dpi(9) or dpi(0),
      bottom = user.bar_type == "vertical" and dpi(9) or dpi(0),
      widget = wibox.container.margin
    },
    bg       = beautiful.bg_normal,
    shape    = helpers.rrect(30),
    widget   = wibox.container.background
  }

  -- May god have mercy on my soul for this
  awesome.connect_signal("signal::battery", function(value, state)
      local b = batstatus
      b.state = state
      b.value = value

      if b.state then
          if b.value > 90 then
              bar_btn_bat.image = beautiful.batterycharging100
          elseif b.value > 80 then
              bar_btn_bat.image = beautiful.batterycharging90
          elseif b.value > 70 then
              bar_btn_bat.image = beautiful.batterycharging80
          elseif b.value > 60 then
              bar_btn_bat.image = beautiful.batterycharging70
          elseif b.value > 50 then
              bar_btn_bat.image = beautiful.batterycharging60
          elseif b.value > 40 then
              bar_btn_bat.image = beautiful.batterycharging50
          elseif b.value > 30 then
              bar_btn_bat.image = beautiful.batterycharging40
          elseif b.value > 30 then
              bar_btn_bat.image = beautiful.batterycharging40
          elseif b.value > 20 then
              bar_btn_bat.image = beautiful.batterycharging30
          elseif b.value > 10 then
              bar_btn_bat.image = beautiful.batterycharging20
          elseif b.value <= 10 then
              bar_btn_bat.image = beautiful.batterycharging10
          else
              bar_btn_bat.image = beautiful.batterycharging100
          end
      else
          if b.value == 100 then
              bar_btn_bat.image = beautiful.battery
          elseif b.value > 90 then
              bar_btn_bat.image = beautiful.battery
          elseif b.value > 80 then
              bar_btn_bat.image = beautiful.battery90
          elseif b.value > 70 then
              bar_btn_bat.image = beautiful.battery80
          elseif b.value > 60 then
              bar_btn_bat.image = beautiful.battery70
          elseif b.value > 60 then
              bar_btn_bat.image = beautiful.battery70
          elseif b.value > 50 then
              bar_btn_bat.image = beautiful.battery60
          elseif b.value > 40 then
              bar_btn_bat.image = beautiful.battery50
          elseif b.value > 30 then
              bar_btn_bat.image = beautiful.battery40
          elseif b.value > 20 then
              bar_btn_bat.image = beautiful.battery30
          elseif b.value > 10 then
              bar_btn_bat.image = beautiful.battery20
          elseif b.value <= 10 then
              bar_btn_bat.image = beautiful.battery10
          else
              bar_btn_bat.image = beautiful.battery
          end
      end
  end)

  awesome.connect_signal("signal::volume", function(volume, muted)
      if muted then bar_btn_sound.image = beautiful.volumeofficon else bar_btn_sound.image = beautiful.volumeicon end
  end)

  awesome.connect_signal("signal::bluetooth", function(is_enabled)
      if is_enabled then bar_btn_blue.image = beautiful.bluetoothicon else bar_btn_blue.image = beautiful.bluetoothofficon end
  end)

  awesome.connect_signal("signal::network", function(is_enabled)
      bar_btn_net.image = is_enabled and beautiful.wifiicon or beautiful.wifiofficon
  end)

  return buttons

end
