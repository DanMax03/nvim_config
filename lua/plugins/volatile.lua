local g = vim.g
local table_helper = require('helpers/table').table


local result = {}

local function addPlugin (require_path)
   result = table_helper.concat_tables(result, require(require_path))
end


if g.is_idris2_setup then
   addPlugin('plugins/volatile/idris2')
end

return result
