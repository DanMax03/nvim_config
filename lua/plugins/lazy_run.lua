local table_helpers = require('helpers').table


local core_plugins = require('plugins/core')
local volatile_plugins = require('plugins/volatile')
local plugins = table_helpers.concatTables(core_plugins, volatile_plugins)

require('lazy').setup(plugins, {
   defaults = { lazy = true }  -- always go lazy if is not explicit
})

