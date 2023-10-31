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
      -- if none is set, use predefined theme wallpaper
      gears.wallpaper.maximized(beautiful.wallpaper, s, false, nil)
   end
end)
