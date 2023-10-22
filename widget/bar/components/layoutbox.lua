local awful = require('awful')
local user  = require('user')

local function getlayout(s)
    return awful.widget.layoutbox {
        screen  = s,
        visible = user.layout_vis,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc(-1) end),
            awful.button({ }, 5, function () awful.layout.inc( 1) end),
        }
    }
end

return getlayout
