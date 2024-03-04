local M = {}

function M.getTableLength(t)
   local count = 0
   
   for _ in pairs(t) do
      count = count + 1
   end

   return count
end

function M.concatTables(...)
   local arg = {...}
   local result = {}

   for _, t in ipairs(arg) do
      if M.getTableLength(t) == 0 then
         goto continue
      end

      assert(type(t) == 'table', 'Every argument to concat_tables must be a table!')

      for _, entry in ipairs(t) do
         table.insert(result, entry)
      end
      
      ::continue::
   end

   return result
end

return M
