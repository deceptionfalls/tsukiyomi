local wibox     = require('wibox')
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local bling     = require('modules.bling')

local dpi       = beautiful.xresources.apply_dpi
local launcher  = require('widget.launcher')
local helpers   = require('helpers')
local user      = require('user')

-- icon handling
if user.icon == "cookie" then
  icon = beautiful.cookie
elseif user.icon == "cookie_small" then
  icon = beautiful.cookie_small
elseif user.icon == "moon" then
  icon = beautiful.moon
end

return function ()

  local home = wibox.widget {
    {
      {
        {
          image  = user.icon_style == "filled" and gears.color.recolor_image(icon, beautiful.accent) or icon,
          widget = wibox.widget.imagebox
        },
        margins = dpi(5),
        widget  = wibox.container.margin
      },
      align  = "center",
      widget = wibox.container.place
    },
    bg      = beautiful.bg_normal,
    visible = user.homeicon_vis,
    shape   = user.style == "rounded" and gears.shape.circle or gears.shape.rectangle,
    forced_height = user.bar_type == "vertical" and dpi(30) or dpi(70),
    forced_width  = user.bar_type == "vertical" and dpi(50) or dpi(32),
    widget  = wibox.container.background,
    spacing = user.spacing,
    buttons = {
      awful.button({}, 1, function()
        local app_launcher = bling.widget.app_launcher(launcher)
        app_launcher:toggle()
      end)
    },
  }

  helpers.hoverCursor(home)

  return home
end
