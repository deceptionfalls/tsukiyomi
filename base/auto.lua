local awful = require('awful')
local user  = require('user')

-- handle desktop icons
if user.desktop_icon == true then awful.spawn.once('nemo-desktop') end

-- handle music shit
if user.music_enabled == true then
  awful.spawn.once('mpd')
  awful.spawn.once('mpDris2')
  awful.spawn.once('clematis') -- rpc
end

awful.spawn.once('picom')
awful.spawn.once('xsettingsd')
