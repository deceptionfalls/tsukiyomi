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
elseif user.icon == "star" then
  icon = beautiful.star
elseif user.icon == "cookie_small" then
  icon = beautiful.cookie_small
elseif user.icon == "moon" then
  icon = beautiful.moon
elseif user.icon == "awm" then
  icon = beautiful.awesome_icon
end

return function ()

  local home = wibox.widget {
    {
      {
        {
          image  = icon,
          halign = "center",
          valign = "center",
          widget = wibox.widget.imagebox
        },
        margins = dpi(5),
        widget  = wibox.container.margin
      },
      align  = "center",
      widget = wibox.container.place
    },
    bg      = user.icon == "awm" and beautiful.bg_dark or beautiful.bg_normal,
    shape   = user.style == "rounded" and gears.shape.circle,
    widget  = wibox.container.background,
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
