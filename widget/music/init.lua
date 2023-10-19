local gears     = require("gears")
local awful     = require("awful")
local beautiful = require("beautiful")
local ruled     = require("ruled")
local wibox     = require("wibox")
local dpi       = beautiful.xresources.apply_dpi
local helpers   = require("helpers")
local user      = require("user")

local control_button_bg = beautiful.transparent
local control_button_bg_hover = beautiful.bg_light
local control_button = function(c, symbol, color, size, on_click, on_right_click)
    local icon = wibox.widget{
        markup = helpers.colorizeText(symbol, color),
        font = beautiful.font .. "16",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox()
    }

    local button = wibox.widget {
        icon,
        bg = control_button_bg,
        shape = user.style == "rounded" and helpers.rrect(dpi(4)) or gears.shape.rectangle,
        widget = wibox.container.background
    }

    local container = wibox.widget {
        button,
        strategy = "min",
        width = dpi(30),
        widget = wibox.container.constraint,
    }

    container:buttons(gears.table.join(
        awful.button({ }, 1, on_click),
        awful.button({ }, 3, on_right_click)
    ))

    container:connect_signal("mouse::enter", function ()
        button.bg = control_button_bg_hover
    end)
    container:connect_signal("mouse::leave", function ()
        button.bg = control_button_bg
    end)

    return container
end

local music_play_pause = control_button(c, "󰏤", beautiful.fg_normal, dpi(30), function()
    awful.spawn.with_shell("mpc --host localhost --port 8800 -q toggle")
end)

local loop = control_button(c, "󰑖", beautiful.fg_normal, dpi(30), function()
    awful.spawn.with_shell("mpc --host localhost --port 8800 repeat")
end)

local shuffle = control_button(c, "󰒝", beautiful.fg_normal, dpi(30), function()
    awful.spawn.with_shell("mpc --host localhost --port 8800 random")
end)

local music_create_decoration = function (c)

    -- Toolbar
    awful.titlebar(c, { position = "bottom", size = dpi(60), bg = beautiful.bg_normal }):setup {
        {
            {
                {
                    -- Go to playlist and focus currently playing song
                    control_button(c, "󰒮", beautiful.fg_normal, dpi(30), function()
                        awful.spawn.with_shell("mpc --host localhost --port 8800 -q prev")
                    end),
                    -- Toggle play pause
                    music_play_pause,
                    -- Go to list of playlists
                    control_button(c, "󰒭", beautiful.fg_normal, dpi(30), function()
                        awful.spawn.with_shell("mpc --host localhost --port 8800 -q next")
                    end),
                    layout = wibox.layout.flex.horizontal
                },
                nil,
                {
                    loop,
                    shuffle,
                    spacing = dpi(10),
                    layout = wibox.layout.fixed.horizontal
                },
                layout = wibox.layout.align.horizontal
            },
            top     = dpi(20),
            bottom  = dpi(20),
            left    = dpi(20),
            right   = dpi(20),
            widget  = wibox.container.margin
        },
        layout = wibox.layout.align.vertical
    }

    -- Set custom decoration flags
    c.custom_decoration = { bottom = true }
end

-- Add the titlebar whenever a new music client is spawned
ruled.client.connect_signal("request::rules", function()
    ruled.client.append_rule {
        id = "ncmpcpp",
        rule = {instance = "ncmpcpp"},
        callback = music_create_decoration
    }
end)
