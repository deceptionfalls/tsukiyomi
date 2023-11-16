local naughty   = require('naughty')
local batstatus = require('widget.bar.components.battery')

-- Flags to track notification state
local batteryLowNotified    = false
local batteryFullNotified   = false
local batteryChargeNotified = false

awesome.connect_signal("signal::battery", function(value, state)
  batstatus.state = state
  batstatus.value = value

  if batstatus.state then
    if not batteryChargeNotified then
      naughty.notification {
        title   = "Power Management",
        message = "Battery is charging", timeout = 0
      }
      batteryChargeNotified = true
    end
  else
    if batstatus.value <= 18 and not batteryLowNotified then
      naughty.notification {
        title   = "Power Management",
        message = "Battery is running low!", timeout = 0
      }
      batteryLowNotified = true
    end

    if batstatus.value == 100 and not batteryFullNotified then
      naughty.notification {
        title   = "Power Management",
        message = "Battery is full!", timeout = 0
      }
      batteryFullNotified = true
    end
  end
end)
