local awful     = require("awful")
local beautiful = require("beautiful")
local gears     = require("gears")
local wibox     = require("wibox")

local playerctl = require("modules.bling").signal.playerctl.lib()
local dpi       = beautiful.xresources.apply_dpi
local user      = require("user")
local helpers   = require("helpers")

local album_art = wibox.widget{
    widget        = wibox.widget.imagebox,
    clip_shape    = helpers.rrect(15),
    forced_height = dpi(85),
    forced_width  = dpi(85),
    image         = beautiful.cookie3,
}

local song_artist = wibox.widget{
    widget  = wibox.widget.textbox,
    markup  = helpers.colorizeText("Unknown", beautiful.mid_light),
    font    = beautiful.font .. "Medium",
    align   = "left",
    valign  = "center"
}

local song_name = wibox.widget{
    widget  = wibox.widget.textbox,
    markup  = helpers.colorizeText("None", beautiful.fg_normal),
    font    = beautiful.font .. "Bold",
    align   = "left",
    valign  = "center"
}

local toggle_button = wibox.widget{
    widget  = wibox.widget.textbox,
    markup  = helpers.colorizeText("󰏤", beautiful.fg_normal),
    font    = beautiful.font .. "24",
    align   = "right",
    valign  = "center"
}

local next_button = wibox.widget{
    widget  = wibox.widget.textbox,
    markup  = helpers.colorizeText("󰒭", beautiful.fg_normal),
    font    = beautiful.font .. "24",
    align   = "right",
    valign  = "center"
}

-- prev button
local prev_button = wibox.widget{
    widget  = wibox.widget.textbox,
    markup  = helpers.colorizeText("󰒮", beautiful.fg_normal),
    font    = beautiful.font .. "24",
    align   = "right",
    valign  = "center"
}

local toggle_command  = function() playerctl:play_pause() end
local prev_command    = function() playerctl:previous() end
local next_command    = function() playerctl:next() end

toggle_button:buttons(gears.table.join(
    awful.button({}, 1, function() toggle_command() end)))

next_button:buttons(gears.table.join(
    awful.button({}, 1, function() next_command() end)))

prev_button:buttons(gears.table.join(
    awful.button({}, 1, function() prev_command() end)))

helpers.hoverCursor(toggle_button)
helpers.hoverCursor(prev_button)
helpers.hoverCursor(next_button)

playerctl:connect_signal("metadata", function(_, title, artist, album_path, __, ___, ____)
	if title == "" then
		title = "None"
	end
	if artist == "" then
		artist = "Unknown"
	end
	if album_path == "" then
		album_path = beautiful.cookie3
	end

	album_art:set_image(gears.surface.load_uncached(album_path))
  song_name:set_markup_silently(helpers.colorizeText(title, beautiful.fg_normal))
	song_artist:set_markup_silently(helpers.colorizeText(artist, beautiful.mid_light))

end)

playerctl:connect_signal("playback_status", function(_, playing, __)
	if playing then
        toggle_button.markup = helpers.colorizeText("󰏤", beautiful.fg_normal)
	else
        toggle_button.markup = helpers.colorizeText("󰐊", beautiful.fg_normal)
	end
end)

return function ()
  local widget = wibox.widget {
      {
          {
              album_art,
              {
                  {
                      nil,
                      {
                          {
                              step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
                              widget        = wibox.container.scroll.horizontal,
                              forced_width  = dpi(170),
                              speed         = 30,
                              song_name,
                          },
                          {
                              step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
                              widget        = wibox.container.scroll.horizontal,
                              forced_width  = dpi(170),
                              speed         = 30,
                              song_artist,
                          },
                          spacing = dpi(2),
                          layout  = wibox.layout.fixed.vertical,
                      },
                      layout = wibox.layout.align.vertical,
                      expand = "none"
                  },
                  {
                      prev_button,
                      toggle_button,
                      next_button,
                      layout  = wibox.layout.fixed.horizontal,
                      spacing = dpi(15)
                  },
                  layout  = wibox.layout.fixed.horizontal,
                  spacing = dpi(50)
              },
              layout = wibox.layout.fixed.horizontal,
              spacing = dpi(10)
          },
          margins   = dpi(12),
          widget    = wibox.container.margin
      },
      widget        = wibox.container.background,
      forced_height = dpi(110),
      bg            = beautiful.bg_normal,
      shape         = helpers.rrect(15)
  }
  return widget
end
