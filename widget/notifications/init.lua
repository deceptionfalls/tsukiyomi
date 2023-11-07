local awful     = require('awful')
local wibox     = require('wibox')
local ruled     = require('ruled')
local naughty   = require('naughty')
local beautiful = require('beautiful')

local user      = require('user')
local dpi       = beautiful.xresources.apply_dpi

naughty.config.defaults.ontop         = true
naughty.config.defaults.screen        = awful.screen.focused()
naughty.config.defaults.border_width  = 0
naughty.config.defaults.title         = "Notification"

ruled.notification.connect_signal('request::rules', function()

    ruled.notification.append_rule {
        rule       = { urgency = 'critical' },
        properties = {
          bg       = beautiful.bg_dark,
          fg       = beautiful.fg_red,
          position = user.notification_pos,
          spacing  = dpi(user.outer_gaps),
          timeout  = 5
      }
    }
    ruled.notification.append_rule {
        rule       = { urgency  = 'normal' },
        properties = {
          bg       = beautiful.bg_dark,
          fg       = beautiful.fg_normal,
          position = user.notification_pos,
          spacing  = dpi(user.outer_gaps),
          timeout  = 5
        }
    }
    ruled.notification.append_rule {
        rule       = { urgency = 'low' },
        properties = {
          bg       = beautiful.bg_dark,
          fg       = beautiful.fg_normal,
          position = user.notification_pos,
          spacing  = dpi(user.outer_gaps),
          timeout  = 5
        }
    }

end)

naughty.connect_signal("request::display", function(n)
  naughty.layout.box {
    notification = n,
    type = "notification",
    bg = beautiful.bg_dark,
    widget_template = {
      {
        {
          {
            {
              {
                {
                  naughty.widget.title,
                  forced_height = dpi(31),
                  layout = wibox.layout.align.horizontal
                },
                left    = dpi(15),
                right   = dpi(15),
                top     = dpi(10),
                bottom  = dpi(10),
                widget  = wibox.container.margin
              },
              bg        = beautiful.bg_normal,
              widget    = wibox.container.background
            },
            strategy    = "min",
            width       = dpi(300),
            widget      = wibox.container.constraint
          },
          strategy      = "max",
          width         = dpi(400),
          widget        = wibox.container.constraint
        },
        {
          {
            {
              naughty.widget.message,
              left      = dpi(15),
              right     = dpi(15),
              top       = dpi(15),
              bottom    = dpi(15),
              widget    = wibox.container.margin
            },
            strategy    = "min",
            height      = dpi(60),
            widget      = wibox.container.constraint
          },
          strategy      = "max",
          width         = dpi(400),
          widget        = wibox.container.constraint
        },
        layout = wibox.layout.align.vertical
      },
      id = "background_role",
      widget = naughty.container.background,
    }
  }
end)
