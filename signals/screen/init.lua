local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')
local gears     = require('gears')

local dpi       = beautiful.xresources.apply_dpi
local user      = require('user')

screen.connect_signal('request::wallpaper', function(s)

      -- This will only work if you compile awesome with this patch added:
      -- https://github.com/awesomeWM/awesome/pull/3811
      -- Cause that enables the use of "cover" so we can set our notches
      -- while keeping the wallpaper fitting the screen properly
      awful.wallpaper {
         screen         = s,
         honor_workarea = true,
         bg             = beautiful.bg_dark,
         widget         = {
            {
              image                 = user.wallpaper or beautiful.wallpaper,
              valign                = "center",
              halign                = "center",
              horizontal_fit_policy = "cover",
              vertical_fit_policy   = "cover",
              widget                = wibox.widget.imagebox,
            },
            widget = wibox.container.background,
            -- GNOME style notches around the bar, this handles the corners to round depending on bar position
            shape  = function(c, w, h)
              if user.bar_pos == "top" then
                gears.shape.partially_rounded_rect(c, w, h, true, true, false, false, dpi(12))
              elseif user.bar_pos == "bottom" then
                gears.shape.partially_rounded_rect(c, w, h, false, false, true, true, dpi(12))
              elseif user.bar_pos == "left" then
                gears.shape.partially_rounded_rect(c, w, h, true, false, false, true, dpi(12))
              elseif user.bar_pos == "right" then
                gears.shape.partially_rounded_rect(c, w, h, false, true, true, false, dpi(12))
              end
            end,
         }
      }
end)
