local ruled     = require("ruled")
local awful     = require("awful")
local user      = require("user")

ruled.client.connect_signal("request::rules", function()
    ruled.client.append_rule {
      id = "global",
      rule = { },
      properties = {
        raise = true,
        size_hints_honor = false,
        screen = awful.screen.preferred,
        focus = awful.client.focus.filter,
        placement = function(c)
          awful.placement.centered(c, c.transient_for)
          awful.placement.no_overlap(c)
          awful.placement.no_offscreen(c)
        end,
      }
    }

    if user.desktop_icon == true then
      ruled.client.append_rule {
        id          = "desktop",
        rule_any    = {
          class   = {
            "Nemo-desktop"
          }
        },
        properties  = {
          -- tag = " ",
          border_width = 0,
          sticky = true
        }
      }
    end

    ruled.client.append_rule {
        id        = "floating",
        rule_any  = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv", "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer", "feh", "qview"
            },
            name    = {
                "Event Tester",  -- xev.
            },
            role    = {
                "AlarmWindow",    -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    }

    if user.titlebar == true then
      ruled.client.append_rule {
          id         = "titlebars",
          rule_any   = { type = { "normal" } },
          properties = { titlebars_enabled = true },
      }
    end

    ruled.client.append_rule { rule = { class = user.browser, user.chatapp }, properties = { screen = 1, tag = "1" } }
end)
