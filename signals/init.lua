local user = require('user')

require('signals.screen')
require('signals.client')
require('signals.ruled')
require('signals.tag')
require('signals.volume')
require('signals.network')
require('signals.compositor')
require('signals.caffeine')

if user.bluetooth_enabled then
  require('signals.bluetooth')
end

if user.battery_enabled then
  require('signals.battery')
end

-- if user.music_enabled then
--   require('signals.music')
-- end
