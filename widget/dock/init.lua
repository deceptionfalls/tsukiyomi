local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local helpers   = require("helpers")
local beautiful = require("beautiful")

local dpi       = beautiful.xresources.apply_dpi
local user      = require("user")
local geticon   = require("widget.dock.geticon")

local placeDock = function(c, m)
  awful.placement.bottom(c, { margins = dpi(m) })
end

local layout     = wibox.layout.fixed.horizontal
local rlayout    = wibox.layout.fixed.vertical
local flexlayout = wibox.layout.flex.horizontal

local dock = function(s)
  -- this is the main dock
  local dock  = awful.popup {
    widget    = wibox.container.background,
    ontop     = true,
    bg        = beautiful.bg_dark,
    visible   = true,
    screen    = s,
    height    = 150,
    width     = 600,
    placement = function(c) placeDock(c, 10) end,
    shape     = user.style == "rounded" and helpers.rrect(10)
  }

  -- autohiding the dock
  local function check_for_dock_hide()
  if not awful.screen.focused().selected_tag then
    dock.visible = true -- No tag selected, so make the dock visible
    return
  end

  for _, client in ipairs(awful.screen.focused().selected_tag:clients()) do
    if client.fullscreen then
      dock.visible = false -- Disable dock on fullscreen
      return
    end
  end

  -- Make dock visible if nothing is open
  if #awful.screen.focused().selected_tag:clients() < 1 then
    dock.visible = true
    return
  end

    if awful.screen.focused() == mouse.screen then
    local minimized

    for _, c in ipairs(awful.screen.focused().selected_tag:clients()) do
      if c.minimized then
        minimized = true
      end

      if c.fullscreen then
        dock.visible = false
        return
      end

      if not c.minimized then
      -- If the client enters the dock area, hide it
      local y = c:geometry().y
      local h = c.height

        if (y + h) >= awful.screen.focused().geometry.height - 85 then
          dock.visible = false
          return
        else
          dock.visible = true
        end
      end
    end

    if minimized then
      dock.visible = true
    end
    else
      dock.visible = false
    end
  end

  -- a timer to check for dock hide
  local dockHide = gears.timer {
    timeout = 1,
    autostart = true,
    call_now = true,
    callback = function()
      check_for_dock_hide()
    end
  }

  dockHide:again()

  -- a hotarea at the bottom which will toggle the dock upon hover
  local hotpop = wibox({
    type    = "desktop",
    height  = user.inner_gaps * 3,
    width   = 200,
    screen  = s,
    ontop   = true,
    visible = true,
    bg      = beautiful.bg_dark .. '00'
  })

  placeDock(hotpop, 0)
  hotpop:setup {
    widget  = wibox.container.margin,
    margins = 10,
    layout  = layout
  }

  -- Window state indicators
  local createDockIndicators = function(data)
    local clients = data.clients
    local indicators = wibox.widget { layout = flexlayout, spacing = 4 }

    for _, v in ipairs(clients) do
      local bac
      local click

      if v == client.focus then
        bac = beautiful.cyan
        click = function()
          v.minimized = true
        end

      elseif v.urgent then
        bac = beautiful.red

      elseif v.minimized then
        bac = beautiful.blue
        click = function()
          v.minimized = false
          v = client.focus
        end

      elseif v.maximized then
        bac = beautiful.green
        click = function()
          v.maximized = false
          v = client.focus
        end

      elseif v.fullscreen then
        bac = beautiful.yellow
        click = function()
          v.fullscreen = false
          v = client.focus
        end

      else
        bac = beautiful.fg_normal .. '66'
        click = function()
          v.minimized = true
        end

      end

      local widget = wibox.widget {
        bg            = bac,
        forced_height = dpi(5),
        forced_width  = dpi(20),
        shape         = user.style == "rounded" and helpers.rrect(50),
        widget        = wibox.container.background,
        buttons = {
          awful.button({}, 1, function()
            click()
          end)
        },
      }

      indicators:add(widget)
    end

    return wibox.widget {
      {
        {
          indicators,
          spacing   = user.spacing,
          layout    = layout
        },
        widget      = wibox.container.place,
        halign      = 'center'
      },
      forced_height = 4,
      forced_width  = 45,
      widget        = wibox.container.background
    }

  end

  -- creating 1 icon on the dock
  local createDockElement = function(data)

    local class     = string.lower(data.class)
    local command   = string.lower(data.class)

    -- 
    local customIcons = {
      {
        name        = "st",
        convert     = "xfce4-terminal",
        command     = "st"
      },
      {
        name        = "neovim",
        convert     = "neovim",
        command     = user.term_cmd .. "neovim -e nvim"
      },
      {
        name        = "steam",
        convert     = "steam",
        command     = "steam-native"
      },
      {
        name        = "ncmpcpp",
        convert     = "spotify",
        command     = user.term_cmd .. "ncmpcpp -e ncmpcpp"
      },
    }

    for _, v in pairs(customIcons) do
      if class == v.name then
        class   = v.convert
        command = v.command
      end
    end

    local dockelement = wibox.widget {
      {
        {
          {
            forced_height = 50,
            forced_width  = 50,
            buttons = {
              awful.button({}, 1, function()
                awful.spawn.with_shell(command)
              end)
            },
            image      = geticon(nil, class, class, false),
            clip_shape = user.style == "rounded" and helpers.rrect(8),
            widget     = wibox.widget.imagebox,
          },
          layout = layout
        },
        createDockIndicators(data),
        layout = rlayout
      },
      forced_width = 50,
      widget = wibox.container.background
    }
    return dockelement
  end

  -- the main function
  local createDockElements = function()
    if not mouse.screen then
      return wibox.widget { layout = layout } -- No screen selected, return an empty widget
    end

    local clients = mouse.screen.selected_tag and mouse.screen.selected_tag:clients() or {}

    -- making some pinned apps
    local metadata = {
      {
        count   = 0,
        id      = 1,
        clients = {},
        name    = "nemo",
        class   = "nemo"
      },
      {
        count   = 0,
        id      = 2,
        clients = {},
        name    = "st",
        class   = "st"
      },
      {
        count   = 0,
        id      = 3,
        clients = {},
        name    = "firefox",
        class   = "firefox"
      },
      {
        count   = 0,
        id      = 4,
        name    = "discord",
        clients = {},
        class   = "discord"
      },
      {
        count   = 0,
        id      = 5,
        name    = "neovim",
        clients = {},
        class   = "neovim"
      },
      {
        count   = 0,
        id      = 6,
        name    = "steam",
        clients = {},
        class   = "steam"
      },
      {
        count   = 0,
        id      = 7,
        name    = "zathura",
        clients = {},
        class   = "zathura"
      },
    }

    local classes = { "st", "discord", "firefox", "nemo", "neovim", "steam", "zathura" }
    local dockElements = wibox.widget { layout = layout, spacing = user.spacing }

    -- generating the data
    for _, c in ipairs(clients) do
      local class = string.lower(c.class)

      if helpers.inTable(classes, class) then
        for _, j in pairs(metadata) do
          if j.name == class then
            table.insert(j.clients, c)
            j.count = j.count + 1
          end
        end

      else
        table.insert(classes, class)
        local toInsert = {
          count   = 1,
          id      = #classes + 1,
          clients = { c },
          class   = class,
          name    = class,
        }
        table.insert(metadata, toInsert)
      end
    end

    table.sort(metadata, function(a, b) return a.id < b.id end)
    for _, j in pairs(metadata) do
      dockElements:add(createDockElement(j))
    end

    helpers.hoverCursor(dockElements)
    return dockElements

  end

  local refresh = function()
    check_for_dock_hide()
    dock:setup {
      {
        createDockElements(),
        layout  = layout
      },
      widget    = wibox.container.margin,
      margins   = {
        top     = 10,
        bottom  = 7,
        left    = 10,
        right   = 10,
      },
    }
  end

  refresh()

  client.connect_signal("focus", function() refresh() end)
  client.connect_signal("property::minimized", function() refresh() end)
  client.connect_signal("property::maximized", function() refresh() end)
  client.connect_signal("manage", function() refresh() end)
  client.connect_signal("unmanage", function() refresh() end)

  hotpop:connect_signal("mouse::enter", function()
    dockHide:stop()
    dock.visible = true
  end)

  hotpop:connect_signal("mouse::leave", function() dockHide:again() end)

  dock:connect_signal("mouse::enter", function()
    dockHide:stop()
    dock.visible = true
  end)

  dock:connect_signal("mouse::leave", function() dockHide:again() end)
  tag.connect_signal("property::selected", function() refresh() end)

end

screen.connect_signal('request::desktop_decoration', function(s)
  dock(s)
end)
