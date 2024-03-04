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
         print('skipping table')
         goto continue
         print('this must never show up')
      end
      print(string.format('Type is %s and size is %d', type(t), M.getTableLength(t)))
      assert(type(t) == 'table', 'Every argument to concat_tables must be a table!')

      for _, entry in ipairs(table) do
         table.insert(result, entry)
      end
      
      ::continue::
   end

   return result
end

return M
