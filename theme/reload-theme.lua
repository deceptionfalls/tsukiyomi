local awful = require("awful")
local gfs   = require("gears.filesystem")
local user  = require('user')

-- Function to reload themes on awm restarts
-- Requires pynvim

local function reload_theme()
  local path = gfs.get_configuration_dir() .. "theme/colorscheme/" .. user.colorscheme .. "/" .. user.colorscheme .. ".sh"
  local awcfg = gfs.get_configuration_dir()
  local reload = "python " .. awcfg .. "scripts/nvim-reload.py"

  local reload_cmd = reload .. " 'source ~/.config/nvim/init.lua'" -- this assumes you have nvim there obv

  awful.spawn.easy_async_with_shell("bash -e " .. path)
  awful.spawn.easy_async_with_shell(reload_cmd, function() end)
end

reload_theme()
