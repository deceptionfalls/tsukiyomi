local naughty   = require('naughty')
local beautiful = require('beautiful')

local audio_on  = beautiful.volumeicon
local audio_off = beautiful.volumeofficon

local timeout = 1.5
local first   = true
awesome.connect_signal('signal::volume', function(volume, muted)
    if first then
        first = false
    else
        local message
        if muted then
            message = "Muted"
        else
            message = tostring(volume) .. "%"
        end
        local notif = naughty.notification({
                title = "Audio", message = message,
                icon = muted and audio_off or audio_on,
                timeout = timeout, app_name = "volume"
            }, notif)
    end
end)

