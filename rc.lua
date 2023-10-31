pcall(require, "luarocks.loader")

local beautiful = require('beautiful')
local gfs       = require('gears.filesystem')
local naughty   = require('naughty')

-- This ensures every error will leave a traceback notification, since awm logs are shit
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "You fucked up hard"..(startup and " during startup!" or "!"),
        message = message
    }
end)

beautiful.init(gfs.get_configuration_dir() .. 'theme/init.lua')

require('user')
require('base')
require('signals')
require('widget')

require('base.auto') -- autostarts last
