local function tableLength(t)
   local count = 0
   for _ in pairs(t) do
      count = count + 1
   end
   return count
end


local core_plugins = require('plugins/core')
local volatile_plugins = require('plugins/volatile')
print(string.format('core_plugins size is %d', tableLength(core_plugins)))
print(string.format('volatile_plugins size is %d', tableLength(volatile_plugins)))
local plugins = require('helpers').table.concat_tables(core_plugins, volatile_plugins)
print(string.format('plugins size is %d', tableLength(plugins)))

print('plugins are:')
for i, plugin in ipairs(plugins) do
   print(string.format('%d: %s', i, plugin[0]))
end

require('lazy').setup({
   plugins
})
