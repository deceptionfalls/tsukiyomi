local helpers        = {}

local awful          = require("awful")
local beautiful      = require("beautiful")
local gears          = require("gears")
local dpi            = beautiful.xresources.apply_dpi
local cairo          = require('lgi').cairo
local capi           = { client = client, mouse = mouse }

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

-- Resize client or factor
local floating_resize_amount = 20
local tiling_resize_factor = 0.10

helpers.resize_client = function(c, direction)
	if c and c.floating or awful.layout.get(capi.mouse.screen) == awful.layout.suit.floating then
		if direction == "up" then
			c:relative_move(0, 0, 0, -floating_resize_amount)
		elseif direction == "down" then
			c:relative_move(0, 0, 0, floating_resize_amount)
		elseif direction == "left" then
			c:relative_move(0, 0, -floating_resize_amount, 0)
		elseif direction == "right" then
			c:relative_move(0, 0, floating_resize_amount, 0)
		end

	elseif awful.layout.get(capi.mouse.screen) ~= awful.layout.suit.floating then
		if direction == "up" then
			awful.client.incwfact(-tiling_resize_factor)
		elseif direction == "down" then
			awful.client.incwfact(tiling_resize_factor)
		elseif direction == "left" then
			awful.tag.incmwfact(-tiling_resize_factor)
		elseif direction == "right" then
			awful.tag.incmwfact(tiling_resize_factor)
		end
	end
end

-- Move client DWIM (Do What I Mean)
-- Move to edge if the client / layout is floating
-- Swap by index if maximized
-- Else swap client by direction
function helpers.move_client(c, direction)
	if c.floating or (awful.layout.get(capi.mouse.screen) == awful.layout.suit.floating) then
	  client.move_to_edge(c, direction)
	elseif awful.layout.get(capi.mouse.screen) == awful.layout.suit.max then
		if direction == "up" or direction == "left" then
			awful.client.swap.byidx(-1, c)
		elseif direction == "down" or direction == "right" then
			awful.client.swap.byidx(1, c)
		end
	else
		awful.client.swap.bydirection(direction, c, nil)
	end
end

function helpers.centered_client_placement(c)
	return gears.timer.delayed_call(function()
		awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
	end)
end

return helpers
