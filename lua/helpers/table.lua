local M = {}

function M.getTableLength(t)
   local count = 0
   
   for _ in pairs(t) do
      count = count + 1
   end

   return count
end

function M.concatTables(...)
   result = {}

   print('got into concat_tables')

   for _, table in ipairs(arg) do
      assert(type(elem) == 'table', 'Every argument to concat_tables must be a table!')

      for _, entry in ipairs(table) do
         table.insert(result, entry)
      end
   end

   return result
end

return M
