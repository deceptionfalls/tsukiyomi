local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local beautiful = require("beautiful")

local helpers   = require("helpers")
local user      = require("user")
local dpi       = beautiful.xresources.apply_dpi

return function()
  local profile_image = wibox.widget {
      {
          image       = user.avatar,
          clip_shape  = gears.shape.circle,
          widget      = wibox.widget.imagebox
      },
      forced_width    = dpi(45),
      forced_height   = dpi(45),
      shape           = user.style == "rounded" and gears.shape.circle or user.style == "semi-rounded" and helpers.rrect(5) or gears.shape.rectangle,
      widget          = wibox.container.background,
  }

  local username = wibox.widget{
      widget     = wibox.widget.textbox,
      markup     = user.username:gsub("^%l", string.upper),
      font       = beautiful.font .. "Bold",
      align      = "left",
      valign     = "center"
  }

  local desc     = wibox.widget{
      widget     = wibox.widget.textbox,
      markup     = helpers.colorizeText("user@machine", beautiful.mid_light),
      font       = beautiful.font,
      align      = "left",
      valign     = "center"
  }
  awful.spawn.easy_async_with_shell(
    "uname -n", function(stdout)
        local hostname    = stdout:match('(%w+)')
        desc.markup       = helpers.colorizeText(user.username .. "@" .. hostname, beautiful.mid_normal)
    end
  )

  return wibox.widget{
      profile_image,
      {
          nil,
          {
              username,
              desc,
              layout = wibox.layout.fixed.vertical,
              spacing = dpi(1)
          },
          layout = wibox.layout.align.vertical,
          expand = "none"
      },
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(10)
  }
end
