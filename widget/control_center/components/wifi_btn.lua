local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')

return function ()
  local label   = wibox.widget {
    text     = "hi",
    font     = beautiful.font .. "Bold",
    align    = "right",
    widget   = wibox.widget.textbox
  }

  local icon = wibox.widget {
    {
      id     = 'icon',
      image  = beautiful.awesome_icon,
      widget = wibox.widget.imagebox,
      resize = true
    },
    layout = wibox.layout.align.horizontal
  }

  local final_widget = {
    {
      label,
      nil,
      layout = wibox.layout.fixed.horizontal,
    },
    left = dpi(24),
    right = dpi(24),
    forced_height = dpi(48),
    widget = wibox.container.margin
  }

  return final_widget
end
