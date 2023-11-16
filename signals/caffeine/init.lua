local awful = require('awful')
local gears = require('gears')

local status_old = -1

local function emit_caffeine_status()
    awful.spawn.easy_async_with_shell(
        "bash -c 'pgrep caffeinate'", function(stdout)
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
    awful.spawn.easy_async("pgrep caffeinate", function(stdout)
        local is_running = stdout ~= ""
        if is_running then
            awful.spawn("killall caffeinate")
        else
            awful.spawn("caffeinate sleep 9999999")
        end
        awesome.emit_signal("signal::caffeine", not is_running)  -- Invert the status
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
