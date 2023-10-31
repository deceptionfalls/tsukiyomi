local awful = require('awful')
local user  = require('user')

-- handle styles
if user.style == "rounded" then
  awful.spawn.easy_async_with_shell('picom --corner-radius 15') else
  awful.spawn.easy_async_with_shell('picom')
end

-- handle desktop icons
if user.desktop_icon == true then awful.spawn.once('nemo-desktop') end

-- handle music shit
if user.music_enabled == true then
  awful.spawn.once('mpd')
  awful.spawn.once('mpDris2')
  awful.spawn('clematis') -- rpc
end

awful.spawn.once('xsettingsd')
