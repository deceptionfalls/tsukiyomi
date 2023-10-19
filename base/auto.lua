local awful = require('awful')
local user  = require('user')

if user.style == "rounded" then
  awful.spawn.easy_async_with_shell('picom --corner-radius 15')
else
  awful.spawn.easy_async_with_shell('picom')
end

awful.spawn.once('mpd')
