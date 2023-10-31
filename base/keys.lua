local awful         = require("awful")
local bling         = require('modules.bling')
local hotkeys_popup = require("awful.hotkeys_popup")

local launcher      = require('widget.launcher')
local user          = require("user")

local modkey        = user.modkey
local modkey2       = user.modkey2

require("awful.autofocus")
require("scripts.screenshot")

awful.keyboard.append_global_keybindings({
    -- General
    awful.key(
      { modkey }, "/", function ()
        hotkeys_popup.show_help()
      end,
      { description = "Show keybinds", group = "Awesome" }
    ),

    awful.key(
      { modkey }, "Return", function ()
        awful.spawn(user.terminal)
      end,
      { description = "Spawn terminal", group = "Awesome" }
    ),

    awful.key(
      { modkey, "Shift" }, "Return", function ()
          local app_launcher = bling.widget.app_launcher(launcher)
          app_launcher:toggle()
      end,
      { description = "Spawn app launcher", group = "Awesome" }
    ),

    awful.key(
      { modkey, "Shift" }, "r",
        awesome.restart,
      { description = "Restart awesome", group = "Awesome" }
    ),

    -- Tags
    awful.key(
      { modkey2 }, "Tab",
        awful.tag.viewnext,
      { description = "Jump to next tag", group = "Tags" }
    ),

        awful.key(
      { modkey2, "Shift" }, "Tab",
        awful.tag.viewprev,
      { description = "Jump to previous tag", group = "Tags" }
    ),

    awful.key(
      { modkey }, "numrow", function(i)
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
            tag:view_only()
        end
      end,
      { description = "Jump to respective number tag", group = "Tags" }
    ),

    awful.key(
      { modkey, "Shift" }, "numrow", function(i)
          if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
                client.focus:move_to_tag(tag)
            end
          end
        end,
      { description = "Move focused client to tag", group = "Tags" }
    ),

    -- Windows
    awful.key(
      { modkey, "Shift" }, "j", function ()
        awful.client.swap.bydirection('down', client.swap)
      end,
      { description = "Swap below window", group = "Windows" }
    ),

    awful.key(
      { modkey, "Shift" }, "k", function ()
        awful.client.swap.bydirection('up', client.swap)
      end,
      { description = "Swap above window", group = "Windows" }
    ),

    awful.key(
      { modkey, "Shift" }, "h", function ()
        awful.client.swap.bydirection('left', client.swap)
      end,
      { description = "Swap with left window", group = "Windows" }
    ),

    awful.key(
      { modkey, "Shift" }, "l", function ()
        awful.client.swap.bydirection('right', client.swap)
      end,
      { description = "Swap with right window", group = "Windows" }
    ),

    awful.key(
      { modkey, "Control" }, "l", function ()
        awful.tag.incmwfact( 0.05)
      end,
      { description = "Increase master width", group = "Windows" }
    ),

    awful.key(
      { modkey, "Control" }, "h", function ()
        awful.tag.incmwfact(-0.05)
      end,
      { description = "Decrease master width", group = "Windows" }
    ),

    -- Layout
    awful.key(
      { modkey }, "Tab", function ()
        awful.layout.inc( 1)
      end,
      { description = "Cycle between layouts", group = "Layout" }
    ),

    awful.key(
      { modkey, "Shift" }, "Tab", function ()
        awful.layout.inc(-1)
      end,
      { description = "Reverse cycle between layouts", group = "Layout" }
    ),

    -- Focus
    awful.key(
      { modkey }, "k", function ()
        awful.client.focus.byidx(-1)
      end,
      { description = "Focus on previous tag", group = "Focus" }
    ),

    awful.key(
      { modkey }, "j", function ()
        awful.client.focus.byidx( 1)
      end,
      { description = "Focus on next tag", group = "Focus" }
    ),

    awful.key(
      { modkey }, "h", function ()
        awful.client.focus.bydirection('left')
      end,
      { description = "Focus on left window", group = "Focus" }
    ),

    awful.key(
      { modkey }, "l", function ()
        awful.client.focus.bydirection('right')
      end,
      { description = "Focus on right window", group = "Focus" }
    ),

    -- Apps
    awful.key(
      { modkey }, "w", function ()
        awful.spawn(user.browser)
      end,
      { description = "Spawn browser", group = "Apps" }
    ),

    awful.key(
      { modkey }, "d", function ()
        awful.spawn(user.chatapp)
      end,
      { description = "Spawn chatapp", group = "Apps" }
    ),

    awful.key(
      { modkey }, "s", function ()
        awful.spawn.with_shell("steam-native")
      end,
      { description = "Spawn steam", group = "Apps" }
    ),

    -- Screenshot
    -- requires 'maim', 'slop', 'xclip-git'
    awful.key(
      { modkey }, "q", function ()
        awesome.emit_signal("screenshot::full")
      end,
      { description = "Screenshot whole screen", group = "Screenshot" }
    ),

    awful.key(
      { modkey, "Shift" }, "q", function ()
        awesome.emit_signal("screenshot::part")
      end,
      { description = "Screenshot selection", group = "Screenshot" }
    ),

    -- Volume
    awful.key(
      { nil }, "XF86AudioLowerVolume", function ()
        awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-")
      end,
      { description = "Raise volume", group = "Volume" }
    ),

    awful.key(
      { nil }, "XF86AudioRaiseVolume", function ()
        awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+")
      end,
      { description = "Decrease volume", group = "Volume" }
    ),

        awful.key(
      { nil }, "XF86AudioMute", function ()
        awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
      end,
      { description = "Mute volume", group = "Volume" }
    ),

    awful.key(
      { user.modkey }, "[", function ()
        awful.screen.focused().wibar.visible = not awful.screen.focused().wibar.visible
      end,
      { description = "Toggle bar on/off", group = "Awesome" }
    )
})

-- Music related keybinds, will only be added if music is enabled
if user.music_enabled == true then
  awful.keyboard.append_global_keybindings({
      -- Music Control
      awful.key(
        { modkey }, "u", function ()
          awful.spawn.with_shell("playerctl --player=mpd previous")
        end,
        { description = "Previous song", group = "Music" }
      ),

      awful.key(
        { modkey }, "i", function ()
          awful.spawn.with_shell("playerctl --player=mpd play-pause")
        end,
        { description = "Toggle playback", group = "Music" }
      ),

      awful.key(
        { modkey }, "o", function ()
          awful.spawn.with_shell("playerctl --player=mpd next")
        end,
        { description = "Next song", group = "Music" }
      ),
  })
end

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({

    awful.key(
      { modkey }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end,
      { description = "Toggle fullscreen", group = "Awesome" }
    ),

    awful.key(
      { modkey }, "a", function(c)
        c.maximized = not c.maximized
        c:raise()
      end,
      { description = "Toggle maximized", group = "Awesome" }
    ),

    awful.key(
      { modkey, "Shift" }, "c", function(c)
        c:kill()
      end,
      { description = "Kill, rend and slaughter your windows", group = "Awesome" }
    ),

    awful.key(
      { modkey, "Shift" }, "space", function(c)
        c.floating = not c.floating
				c:raise()
      end,
      { description = "Toggle floating", group = "Awesome" }
    ),
  })
end)

awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "Tags",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "Tags",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    }
})

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)

awful.mouse.append_global_mousebindings({
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext),
})

awful.mouse.append_client_mousebindings({
    awful.button({ }, 1, function (c)
        c:activate { context = "mouse_click" }
    end),
    awful.button({ modkey }, 1, function (c)
        c:activate { context = "mouse_click", action = "mouse_move"  }
    end),
    awful.button({ modkey }, 3, function (c)
        c:activate { context = "mouse_click", action = "mouse_resize"}
    end),
})
