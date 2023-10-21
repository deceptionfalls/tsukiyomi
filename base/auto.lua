local awful = require('awful')
local user  = require('user')

if user.style == "rounded" then
  awful.spawn.easy_async_with_shell('picom --corner-radius 15')
else
  awful.spawn.easy_async_with_shell('picom')
end

if user.desktop_icon == true then awful.spawn.once('nemo-desktop') end
awful.spawn.once('mpd')
awful.spawn.once('mpDris2')
