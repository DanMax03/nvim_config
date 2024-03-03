local g = vim.g


local result = {}

if g.is_idris2_setup then
   table.insert(result, require('plugins/idris2'))
end

return result
