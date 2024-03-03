function concat_tables (...)
   result = {}

   for _, table in ipairs(arg) do
      assert(type(elem) == 'table', 'Every argument to concat_tables must be a table!')

      for _, entry in ipairs(table) do
         table.insert(result, entry)
      end
   end

   return result
end
