-- Stolen from gw with love :3

local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local gears     = require('gears')
local dpi       = beautiful.xresources.apply_dpi
local helpers   = require('helpers')
local rubato    = require('modules.rubato')
local user      = require('user')

local function gettaglist(s)
    return awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {
            shape = user.style == "rounded" and helpers.rrect(50) or gears.shape.rectangle,
        },
        layout = {
            spacing = user.spacing,
            layout  = wibox.layout.fixed.vertical,
        },
        buttons = {
            awful.button({}, 1, function (t)
                t:view_only()
            end),
            awful.button({}, 3, function (t)
                awful.tag.viewtoggle(t)
            end),
            awful.button({}, 4, function (t)
                awful.tag.viewprev(t.screen)
            end),
            awful.button({}, 5, function (t)
                awful.tag.viewnext(t.screen)
            end)
        },
        widget_template = {
            {
                markup = '',
                widget = wibox.widget.textbox,
            },
            id = 'background_role',
            forced_height = dpi(60),
            forced_width  = dpi(60),
            widget = wibox.container.background,
            create_callback = function (self, tag)
                self.animate = rubato.timed {
                    duration = 0.15,
                    subscribed = function (h)
                        self:get_children_by_id('background_role')[1].forced_height = h
                    end
                }

                self.update = function ()
                    if tag.selected then
                        -- Current tag
                        self.animate.target = dpi(80)
                    elseif #tag:clients() > 0 then
                        -- Occupied tag
                        self.animate.target = dpi(50)
                    else
                        -- Empty tag
                        self.animate.target = dpi(30)
                    end
                end

                self.update()
            end,
            update_callback = function (self)
                self.update()
            end,
        }
    }
end

return gettaglist
