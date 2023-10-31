local user  = require('user')

local colorscheme = require('theme.colorscheme.adwaita')
if user.colorscheme ~= nil then
   colorscheme = require('theme.colorscheme.' .. user.colorscheme)
end
return colorscheme
