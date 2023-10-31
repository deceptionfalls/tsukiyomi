local wibox      = require("wibox")
local beautiful  = require("beautiful")

local dpi        = beautiful.xresources.apply_dpi
local user       = require("user")

return function()
  local systray  = wibox.widget {
      {
          horizontal  = user.bar_pos == "vertical" and false or true,
          base_size   = dpi(30),
          widget      = wibox.widget.systray
      },
      align   = "center",
      visible = false,
      layout  = wibox.container.place
  }

  awesome.connect_signal('systray::toggle', function()
    systray.visible = not systray.visible
  end)

  return systray
end
