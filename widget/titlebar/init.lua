local awful        = require("awful")
local wibox        = require("wibox")
local gears        = require("gears")
local helpers      = require("helpers")
local beautiful    = require("beautiful")
local dpi          = beautiful.xresources.apply_dpi
local user         = require("user")

local createButton = function(c, fn)
    local btn = wibox.widget {
      forced_width  = dpi(60),
      forced_height = (user.titlebar_pos == "left" and dpi(40)) or (user.titlebar_pos == "right" and dpi(40)) or dpi(15),
      bg            = beautiful.bg_light,
      shape         = user.style == "rounded" and helpers.rrect(15) or gears.shape.rectangle,
      buttons       = {
        awful.button({}, 1, function()
          fn(c)
        end)
      },
      widget = wibox.container.background
    }

    c:connect_signal("focus", function()
      btn.bg = beautiful.mid_normal
    end)

    c:connect_signal("unfocus", function()
      btn.bg = beautiful.bg_light  -- Reset the button's background color when unfocused
    end)

    return btn
  end

  client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local close = createButton(c, function(c1)
      c1:kill()
    end)

    local maximize = createButton(c, function(c1)
      c1.maximized = not c1.maximized
    end)

    local minimize = createButton(c, function(c1)
      gears.timer.delayed_call(function()
        c1.minimized = not c1.minimized
      end)
    end)
    local buttons = gears.table.join(
      awful.button({}, 1, function()
        client.focus = c
        c:raise()
        awful.mouse.client.move(c)
      end),
      awful.button({}, 3, function()
        client.focus = c
        c:raise()
        awful.mouse.client.resize(c)
      end)
    )
    awful.titlebar(c, {
      size = dpi(40),
      position = user.titlebar_pos
    }):setup {
      {
        {
          {
            {
              minimize,
              maximize,
              close,
              spacing = dpi(user.spacing),
              widget  = wibox.container.place,
              halign  = 'center',
              layout  = (user.titlebar_pos == "left" and wibox.layout.fixed.vertical) or (user.titlebar_pos == "right" and wibox.layout.fixed.vertical) or wibox.layout.fixed.horizontal
            },
            top    = dpi(5),
            bottom = dpi(5),
            widget = wibox.container.margin
          },
          widget = wibox.container.place,
          halign = 'center',
        },
        layout = (user.titlebar_pos == "left" and wibox.layout.align.vertical) or (user.titlebar_pos == "right" and wibox.layout.align.vertical) or wibox.layout.align.horizontal
      },
      right  = dpi(10),
      left   = dpi(10),
      top    = dpi(5),
      bottom = dpi(5),
      widget = wibox.container.margin
    }
end)
