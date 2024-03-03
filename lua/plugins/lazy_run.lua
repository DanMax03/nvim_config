core_plugins = require('plugins/core')
volatile_plugins = require('plugins/volatile')
plugins = require('helpers').concat_tables(core_plugins, volatile_plugins)

require('lazy').setup({
   plugins
})
