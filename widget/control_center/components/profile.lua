local awful     = require("awful")
local gears     = require("gears")
local wibox     = require("wibox")
local beautiful = require("beautiful")

local helpers   = require("helpers")
local user      = require("user")
local dpi       = beautiful.xresources.apply_dpi

local profile_image = wibox.widget {
    {
      image       = user.avatar,
      clip_shape  = user.style == "rounded" and gears.shape.circle,
      widget      = wibox.widget.imagebox
    },
    widget        = wibox.container.background,
    border_width  = dpi(1),
    forced_width  = dpi(75),
    forced_height = dpi(75),
    shape         = gears.shape.circle,
}

-- get user name
local name   = awful.spawn.easy_async_with_shell(
    "whoami", function(stdout)
        local name = stdout:match('(%w+)')
        return name
    end
)

local hostname = awful.spawn.easy_async_with_shell(
    "uname -n", function(stdout)
        local hostname = stdout:match('(%w+)')
        return hostname
    end
)

local username = wibox.widget{
    widget = wibox.widget.textbox,
    markup = string.upper(name),
    font   = user.font .. user.fontsize,
    align  = "left",
    valign = "center"
}

-- description/host
local desc = wibox.widget{
    widget = wibox.widget.textbox,
    markup = helpers.colorizeText(name .. "@" .. hostname, beautiful.fg_normal),
    font   = user.font .. user.fontsize,
    align  = "left",
    valign = "center"
}

-- return
return wibox.widget{
    profile_image,
    {
        nil,
        {
            username,
            desc,
            layout  = wibox.layout.fixed.vertical,
            spacing = dpi(2)
        },
        layout = wibox.layout.align.vertical,
        expand = "none"
    },
    layout  = wibox.layout.fixed.horizontal,
    spacing = dpi(15)
}
