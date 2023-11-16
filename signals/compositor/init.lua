local awful = require('awful')
local gears = require('gears')

local status_old = -1

local function emit_compositor_status()
    awful.spawn.easy_async_with_shell(
        "bash -c 'pgrep picom'", function(stdout)
            local status    = stdout:match("%d+")  -- Check if any process with name 'picom' is running
            local status_id = status and 0 or 1    -- 0 if picom is running, 1 if not running

            if status_id ~= status_old then
                awesome.emit_signal('signal::compositor', status_id)
                status_old = status_id
            end
        end
    )
end

awesome.connect_signal('compositor::toggle', function()
    awful.spawn.easy_async("pgrep picom", function(stdout)
        local is_running = stdout ~= ""
        if is_running then
            awful.spawn("killall picom")
        else
            awful.spawn("picom")
        end
        awesome.emit_signal("signal::compositor", not is_running)  -- Invert the status
    end)
end)

-- Refreshing
gears.timer {
    timeout     = 5,
    call_now    = true,
    autostart   = true,
    callback    = function()
        emit_compositor_status()
    end
}
