-- Corresponds with ../plugins/core.lua

--local builtin = require('telescope.builtin')

--vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
--vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

vim.api.nvim_create_user_command('DiagnosticToggle', function()
   local dconfig = vim.diagnostic.config
   local vt_flag = dconfig().virtual_text

   dconfig({
      virtual_text = not vt_flag,
      underline = not vt_flag,
      signs = not vt_flag
   })

   local vt_flag_str = ''

   if vt_flag then
      vt_flag_str = 'off'
   else
      vt_flag_str = 'on'
   end

   vim.notify(string.format('Diagnostic is %s', vt_flag_str), vim.log.levels.INFO)
end, { desc = 'Toggle diagnostic' })

