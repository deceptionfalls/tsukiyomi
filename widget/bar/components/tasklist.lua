local awful     = require('awful')
local wibox     = require('wibox')
local gears     = require('gears')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi
local helpers   = require('helpers')
local user      = require('user')

local function gettasklist(s)
    return awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        source  = function()
            local ret = {}
            for _, t in ipairs(s.tags) do
                gears.table.merge(ret, t:clients())
            end
            return ret
        end,
        buttons = {
            awful.button({ }, 1, function (c)
                if not c.active then
                    c:activate { switch_to_tag = true }
                else
                    c.minimized = true
                end
            end),
            awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
        },
        layout = {
            spacing = dpi(user.spacing),
            layout  = user.bar_type == "vertical" and wibox.layout.fixed.vertical or wibox.layout.fixed.horizontal
        },
        style = { shape = gears.shape.circle },
        widget_template = {
            {
                {
                    widget  = awful.widget.clienticon
                },
                margins = dpi(user.spacing),
                widget  = wibox.container.margin
            },
            id      = 'background_role',
            widget  = wibox.container.background
        }
    }


end

return gettasklist
