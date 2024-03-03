local core_plugins = require('plugins/core')
local volatile_plugins = require('plugins/volatile')
local plugins = require('helpers').table.concat_tables(core_plugins, volatile_plugins)

require('lazy').setup({
   plugins
})
