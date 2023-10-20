local awful = require('awful')

-- Put new windows in stack
client.connect_signal('manage', function(c)
  if not awesome.startup then awful.client.setslave(c) end
  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    awful.placement.no_offscreen(c)
  end
end)

-- Makes floating windows always stay on top
client.connect_signal("property::floating", function(c)
    if c.floating then
        c.ontop = true
    else
        c.ontop = false
    end
end)

-- Send fullscreen windows to the top.
client.connect_signal('property::fullscreen', function(c) c:raise() end)
