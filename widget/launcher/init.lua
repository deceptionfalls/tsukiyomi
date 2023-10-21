local awful     = require('awful')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi
local helpers   = require("helpers")
local user      = require('user')

return {

    shape                       = user.style == "rounded" and helpers.rrect(10),

    reset_on_hide               = false,
    save_history                = true,
    wrap_page_scrolling         = true, -- leave this in true because it fucking floods me with errors otherwise
    wrap_app_scrolling          = true,

    prompt_show_icon            = false,
    prompt_icon                 = "",
    prompt_text_halign          = "left",

    prompt_height               = dpi(25),
    prompt_margins              = dpi(10),
    prompt_paddings             = dpi(2),

    apps_per_row                = 16,
    apps_per_column             = 1,
    apps_spacing                = dpi(0),

    apps_margin                 = dpi(7),
    app_width                   = dpi(300),
    app_height                  = dpi(35),

    app_name_halign             = "left",
    app_name_valign             = "center",

    app_show_icon               = false,

    app_content_padding         = dpi(10),
    app_content_spacing         = dpi(0),

    prompt_icon_font            = user.font,
    app_name_font               = user.font,

    app_shape                   = user.style == "rounded" and helpers.rrect(15),

    border_color                = beautiful.accent,

    background                  = beautiful.bg_dark,
    prompt_color                = beautiful.bg_dark,
    prompt_border_color         = beautiful.bg_dark,
    prompt_icon_color           = beautiful.bg_dark,
    prompt_text_color           = beautiful.mid_normal,
    prompt_cursor_color         = beautiful.mid_normal,
    app_normal_color            = beautiful.bg_dark,
    app_normal_hover_color      = beautiful.bg_normal,
    app_selected_color          = beautiful.accent,
    app_selected_hover_color    = beautiful.bg_light,
    app_name_normal_color       = beautiful.fg_normal,
    app_name_selected_color     = beautiful.bg_dark,
}
