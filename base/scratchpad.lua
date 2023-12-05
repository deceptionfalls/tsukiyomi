local awful   = require("awful")

local bling   = require("modules.bling")
local user    = require("user")
local modkey  = user.modkey

-- function to make the scratchpads centered
local function center(client)
    local screen = awful.screen.focused()
    local screen_geometry = screen.geometry

    local x = (screen_geometry.width - client.geometry.width) / 2
    local y = (screen_geometry.height - client.geometry.height) / 2

    client.geometry.x = x
    client.geometry.y = y

    client:toggle()
end

local spad = bling.module.scratchpad {
    command = user.term_cmd .. "spad -n spad",
    rule = { instance = "spad" },
    sticky = true,
    autoclose = true,
    floating = true,
    geometry = { height=550, width=900 },
    reapply = true,
    dont_focus_before_close = true,
}

local music = bling.module.scratchpad {
    command = "spotify",
    rule = { instance = "spotify" },
    sticky = true,
    autoclose = true,
    floating = true,
    geometry = { height=550, width=900},
    reapply = true,
    dont_focus_before_close = true,
}

local fileman = bling.module.scratchpad {
    command = user.term_cmd .. "fileman -n fileman -e " .. user.files_cli,
    rule = { instance = "fileman" },
    sticky = true,
    autoclose = true,
    floating = true,
    geometry = { height=550, width=900},
    reapply = true,
    dont_focus_before_close = true,
}

awful.keyboard.append_global_keybindings({
    awful.key({ modkey }, "m", function() center(spad) end),
    awful.key({ modkey }, "n", function() center(music) end),
    awful.key({ modkey }, "b", function() center(fileman) end),
})
