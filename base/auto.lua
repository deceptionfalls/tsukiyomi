local awful = require('awful')
local user  = require('user')

-- handle desktop icons
if user.desktop_icon == true then awful.spawn.once('nemo-desktop') end

-- handle music shit
if user.music_enabled == true then
  if user.music_enabled == "mpd" then
    awful.spawn.once('mpd')
  end
  awful.spawn.once('mpDris2')
end

awful.spawn.once('picom')
awful.spawn.once('xsettingsd')
