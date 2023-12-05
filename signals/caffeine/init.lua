local awful = require('awful')
local gears = require('gears')

local status_old = -1

local function emit_caffeine_status()
    awful.spawn.easy_async_with_shell(
        "bash -c 'pgrep xset'", function(stdout)
            local status    = stdout:match("%d+")
            local status_id = status and 0 or 1

            if status_id ~= status_old then
                awesome.emit_signal('signal::caffeine', status_id)
                status_old = status_id
            end
        end
    )
end

awesome.connect_signal('caffeine::toggle', function()
    awful.spawn.easy_async("pgrep xset", function(stdout)
        local is_running = stdout ~= ""
        if is_running then
            awful.spawn("killall xset")
        else
            awful.spawn("xset s off")
            awful.spawn("xset -dpms")
        end
        awesome.emit_signal("signal::caffeine", not is_running)
    end)
end)

-- Refreshing
gears.timer {
    timeout     = 5,
    call_now    = true,
    autostart   = true,
    callback    = function()
        emit_caffeine_status()
    end
}
