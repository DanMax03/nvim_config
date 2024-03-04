local table_helpers = require('helpers').table


local core_plugins = require('plugins/core')
local volatile_plugins = require('plugins/volatile')
print(string.format('core_plugins size is %d', table_helpers.getTableLength(core_plugins)))
print(string.format('volatile_plugins size is %d', table_helpers.getTableLength(volatile_plugins)))
local plugins = table_helpers.concatTables(core_plugins, volatile_plugins)
print(string.format('plugins size is %d', table_helpers.getTableLength(plugins)))

print('plugins are:')
for i, plugin in ipairs(plugins) do
   print(string.format('%d: %s', i, plugin[0]))
end

require('lazy').setup({
   plugins
})
