local awful = require("awful")
local user = require("user")

tag.connect_signal("request::default_layouts", function(s)
    awful.layout.append_default_layouts(user.layouts, s)
end)
