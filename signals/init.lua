local user = require('user')

require('signals.screen')
require('signals.client')
require('signals.ruled')
require('signals.tag')
require('signals.volume')
require('signals.network')

if user.bluetooth_enabled then
    require('signals.bluetooth')
end

if user.battery_enabled then
    require('signals.battery')
end
