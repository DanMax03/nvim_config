local table_helpers = require('helpers').table


local core_plugins = require('plugins/core')
local volatile_plugins = require('plugins/volatile')
local plugins = table_helpers.concatTables(core_plugins, volatile_plugins)

print('Before lazy')
print(vim.inspect(vim.api.nvim_list_runtime_paths()))

require('lazy').setup(plugins, {
   defaults = { lazy = true }  -- always go lazy if is not explicit
})

print('After lazy')
print(vim.inspect(vim.api.nvim_list_runtime_paths()))
