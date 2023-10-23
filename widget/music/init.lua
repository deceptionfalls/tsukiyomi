local gears     = require("gears")
local awful     = require("awful")
local beautiful = require("beautiful")
local ruled     = require("ruled")
local wibox     = require("wibox")

local helpers   = require("helpers")
local user      = require("user")
local dpi       = beautiful.xresources.apply_dpi

-- whole code is from ner0z's dotfiles, i dont really plan to make my own version of this, lmao
-- https://github.com/ner0z/dotfiles/blob/main/config/awesome/misc/deco.lua

local music_art = wibox.widget {
    image = gears.filesystem.get_configuration_dir() .. "assets/cookie3.svg",
    resize = true,
    widget = wibox.widget.imagebox
}

local music_art_container = wibox.widget{
    music_art,
    shape = helpers.rrect(6),
    widget = wibox.container.background
}

local music_now = wibox.widget{
    font = user.font .. "Bold",
    valign = "center",
    widget = wibox.widget.textbox
}

local music_pos = wibox.widget{
    font = user.font,
    valign = "center",
    widget = wibox.widget.textbox
}

local music_bar = wibox.widget {
    max_value = 100,
    value = 0,
    background_color = beautiful.bg_dark,
    color = beautiful.accent,
    forced_height = dpi(3),
    widget = wibox.widget.progressbar
}

local control_button_bg = beautiful.transparent
local control_button_bg_hover = beautiful.bg_normal

local control_button = function(c, symbol, color, size, on_click, on_right_click)
    local icon = wibox.widget{
        markup = helpers.colorizeText(symbol, color),
        font   = user.font,
        align  = "center",
        valign = "center",
        widget = wibox.widget.textbox()
    }

    local button = wibox.widget {
        icon,
        bg = control_button_bg,
        shape = helpers.rrect(dpi(4)),
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
    awful.spawn.with_shell("playerctl --all-players play-pause")
end)

local music_play_pause_textbox = music_play_pause:get_all_children()[1]:get_all_children()[1]

local mpc = require("modules.bling").signal.playerctl.lib()
local music_length = 0

mpc:connect_signal("metadata", function(_, title, artist, album_path, album, ___, player_name)
    if player_name == "mpd" then
        local m_now = title .. " - " .. artist

        music_art:set_image(gears.surface.load_uncached(album_path))
        music_now:set_markup_silently(m_now)
    end
end)

mpc:connect_signal("position", function(_, interval_sec, length_sec, player_name)
    if player_name == "mpd" then
        local pos_now = tostring(os.date("!%M:%S", math.floor(interval_sec)))
        local pos_length = tostring(os.date("!%M:%S", math.floor(length_sec)))
        local pos_markup = pos_now .. helpers.colorizeText(" / " .. pos_length, beautiful.accent)

        music_art:set_image(gears.surface.load_uncached(album_path))
        music_pos:set_markup_silently(pos_markup)
        music_bar.value = (interval_sec / length_sec) * 100
        music_length = length_sec
    end
end)

mpc:connect_signal("playback_status", function(_, playing, player_name)
    if player_name == "mpd" then
        if playing then
            music_play_pause_textbox:set_markup_silently("󰏤")
        else
            music_play_pause_textbox:set_markup_silently("󰐊")
        end
    end
end)

local music_create_decoration = function (c)

    -- Hide default titlebar
    awful.titlebar.hide(c, user.titlebar_pos)

    -- Sidebar
    awful.titlebar(c, { position = "left", size = dpi(250), bg = beautiful.bg_normal }):setup {
        nil,
        {
            music_art_container,
            left    = dpi(15),
            right   = dpi(15),
            widget  = wibox.container.margin
        },
        nil,
        expand = "none",
        layout = wibox.layout.align.vertical
    }

    -- Toolbar
    awful.titlebar(c, { position = "bottom", size = dpi(63), bg = beautiful.bg_light }):setup {
        music_bar,
        {
            {
                {
                    -- Go to playlist and focus currently playing song
                    control_button(c, "󰒮", beautiful.fg_normal, dpi(30), function()
                        awful.spawn.with_shell("playerctl --all-players previous")
                    end),
                    -- Toggle play pause
                    music_play_pause,
                    -- Go to list of playlists
                    control_button(c, "󰒭", beautiful.fg_normal, dpi(30), function()
                        awful.spawn.with_shell("playerctl --all-players next")
                    end),
                    layout = wibox.layout.flex.horizontal
                },
                {
                    {
                        step_function = wibox.container.scroll
                            .step_functions
                            .waiting_nonlinear_back_and_forth,
                        speed = 50,
                        {
                            widget = music_now,
                        },
                        widget = wibox.container.scroll.horizontal
                    },
                    left = dpi(20),
                    right = dpi(20),
                    widget = wibox.container.margin
                },
                {
                    music_pos,
                    spacing = dpi(10),
                    layout = wibox.layout.fixed.horizontal
                },
                layout = wibox.layout.align.horizontal
            },
            top     = dpi(15),
            bottom  = dpi(15),
            left    = dpi(25),
            right   = dpi(25),
            widget  = wibox.container.margin
        },
        layout = wibox.layout.align.vertical
    }

    -- Set custom decoration flags
    c.custom_decoration = { left = true, bottom = true }
end

-- Add the titlebar whenever a new music client is spawned
ruled.client.connect_signal("request::rules", function()
    ruled.client.append_rule {
        id = "ncmpcpp",
        rule = {instance = "ncmpcpp"},
        callback = music_create_decoration
    }
end)
