local user = require('user')

local colorscheme = require('theme.colorscheme.biscuit_dark')
if user.colorscheme ~= nil then
   colorscheme = require('theme.colorscheme.' .. user.colorscheme)
end

return colorscheme
