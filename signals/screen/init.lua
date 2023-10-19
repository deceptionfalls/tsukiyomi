local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')
local gears     = require('gears')

local user      = require('user')

screen.connect_signal('request::wallpaper', function(s)

    if user.wallpaper ~= nil then
      -- if a wallpaper is set, use it
      gears.wallpaper.maximized(user.wallpaper, s, false, nil)
   else
      -- if none is set, use color
      awful.wallpaper {
         screen = s,
         honor_workarea = false,
         bg = beautiful.bg_normal,
         widget = {
            widget = wibox.container.background,
            bg = beautiful.bg_normal,
         }
      }
   end
end)
