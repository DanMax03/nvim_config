local g = vim.g
local table_helper = require('helpers').table


local result = {}

local function addPlugin (require_path)
   result = table_helper.concatTables(result, require(require_path))
end


if g.is_idris2_setup then
   addPlugin('plugins/volatile/idris2')
end

return result
