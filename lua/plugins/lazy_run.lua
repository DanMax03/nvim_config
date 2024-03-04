local core_plugins = require('plugins/core')
local volatile_plugins = require('plugins/volatile')
local plugins = require('helpers').table.concat_tables(core_plugins, volatile_plugins)

print('plugins are:')
for _, plugin in ipairs(plugins) do
   print(plugin[0])
end

require('lazy').setup({
   plugins
})
