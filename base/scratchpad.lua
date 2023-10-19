local awful   = require("awful")
local bling   = require("modules.bling")
local user    = require("user")
local modkey  = user.modkey

local spad = bling.module.scratchpad {
    command = "st -c spad -n spad",
    rule = { instance = "spad" },
    sticky = true,
    autoclose = true,
    floating = true,
    geometry = {x=280, y=120, height=550, width=800},
    reapply = true,
    dont_focus_before_close = true,
}

local ncmpcpp = bling.module.scratchpad {
    command = "st -c ncmpcpp -n ncmpcpp -e ncmpcpp",
    rule = { instance = "ncmpcpp" },
    sticky = true,
    autoclose = true,
    floating = true,
    geometry = {x=280, y=120, height=550, width=800},
    reapply = true,
    dont_focus_before_close = true,
}

local fileman = bling.module.scratchpad {
    command = "st -c fileman -n fileman -e " .. user.files_cli,
    rule = { instance = "fileman" },
    sticky = true,
    autoclose = true,
    floating = true,
    geometry = {x=280, y=120, height=550, width=800},
    reapply = true,
    dont_focus_before_close = true,
}

local vol = bling.module.scratchpad {
    command = "st -c vol -n vol -e " .. user.vol_cli,
    rule = { instance = "vol" },
    sticky = true,
    autoclose = true,
    floating = true,
    geometry = {x=280, y=120, height=550, width=800},
    reapply = true,
    dont_focus_before_close = true,
}

awful.keyboard.append_global_keybindings({
    awful.key({ modkey }, "m", function() spad:toggle() end),
    awful.key({ modkey }, "n", function() ncmpcpp:toggle() end),
    awful.key({ modkey }, "b", function() fileman:toggle() end),
    awful.key({ modkey }, "v", function() vol:toggle() end),
})
