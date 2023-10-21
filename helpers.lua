local helpers        = {}
local awful          = require("awful")
local beautiful      = require("beautiful")
local gears          = require("gears")
local dpi            = beautiful.xresources.apply_dpi
local cairo          = require('lgi').cairo

-- i stole all of these

-- from chadcat, this rounds the rect
helpers.rrect        = function(radius)
  radius = radius or dpi(4)
  return function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, radius)
  end
end

-- also from chadcat, this ummm colors text
helpers.colorizeText = function(txt, fg)
  if fg == "" then
    fg = "#ffffff"
  end

  return "<span foreground='" .. fg .. "'>" .. txt .. "</span>"
end

-- got it from blyaticon i forgot what this does
helpers.crop_surface = function(ratio, surf)
   local old_w, old_h = gears.surface.get_size(surf)
   local old_ratio    = old_w / old_h
   if old_ratio == ratio then return surf end

   local new_w = old_w
   local new_h = old_h
   local offset_w, offset_h = 0, 0
   -- quick mafs
   if (old_ratio < ratio) then
      new_h    = math.ceil(old_w * (1 / ratio))
      offset_h = math.ceil((old_h - new_h) / 2)
   else
      new_w    = math.ceil(old_h * ratio)
      offset_w = math.ceil((old_w - new_w) / 2)
   end

   local out_surf = cairo.ImageSurface(cairo.Format.ARGB32, new_w, new_h)
   local cr       = cairo.Context(out_surf)
   cr:set_source_surface(surf, -offset_w, -offset_h)
   cr.operator    = cairo.Operator.SOURCE
   cr:paint()

   return out_surf
end

-- from sammyette, this changes the cursor on hover
function helpers.hoverCursor(w, cursorType)
  cursorType = cursorType or 'hand2'
  local oldCursor = 'left_ptr'
  local wbx

 w.hcDisabled = false
  local enterCb = function()
    wbx = mouse.current_wibox
    if wbx then wbx.cursor = cursorType end
  end
  local leaveCb = function()
    if wbx then wbx.cursor = oldCursor end
  end

  w:connect_signal('hover::disconnect', function()
    w:disconnect_signal('mouse::enter', enterCb)
    w:disconnect_signal('mouse::leave', leaveCb)
    leaveCb()
  end)

  function w:toggleHoverCursor()
   w.hcDisabled = not w.hcDisabled
   if w.hcDisabled then
    leaveCb()
   else
    enterCb()
   end
  end

  w:connect_signal('mouse::enter', enterCb)
  w:connect_signal('mouse::leave', leaveCb)
end

-- i forgot what this does
helpers.inTable = function(t, v)
  for _, value in ipairs(t) do
    if value == v then
      return true
    end
  end

  return false
end

return helpers
