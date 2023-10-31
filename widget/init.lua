local user = require('user')

if user.dock_enabled  == true then require('widget.dock')  end
if user.music_enabled == true then require('widget.music') end

require('widget.bar')
require('widget.titlebar')
require('widget.notifications')
require('widget.launcher')
-- require('widget.control_center')
