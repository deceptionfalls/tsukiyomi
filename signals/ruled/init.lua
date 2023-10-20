local ruled     = require("ruled")
local awful     = require("awful")
local user      = require("user")

ruled.client.connect_signal("request::rules", function()
    ruled.client.append_rule {
      id         = "global",
      rule       = { },
      properties = {
          focus     = awful.client.focus.filter,
          raise     = true,
          screen    = awful.screen.preferred,
          placement = awful.placement.no_overlap+awful.placement.no_offscreen
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
        properties  = { tag = " ", sticky = true }
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

    ruled.client.append_rule { rule = { class = user.browser }, properties = { screen = 1, tag = "1" } }
    ruled.client.append_rule { rule = { class = user.chatapp }, properties = { screen = 1, tag = "2" } }
    ruled.client.append_rule { rule = { class = user.files   }, properties = { screen = 1, tag = "3" } }
end)
