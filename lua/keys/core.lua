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
end, { desc = 'Toggle diagnostic' })

