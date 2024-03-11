local function idris2_write (str, colour)
   local str_no_endline = vim.fn.substitute(str, '\\n$', '', '')

   vim.cmd.echohl(colour)
   vim.cmd.echo('"' .. str_no_endline .. '"')
   vim.cmd.echohl('None')
end


local function idris2_reload ()
   vim.cmd.write()

   local file = vim.fn.expand('%:p')
   local tc = vim.fn.system('idris2 --no-colour --find-ipkg ' .. vim.fn.shellescape(file) .. ' --client ""')

   if tc ~= '' then
      idris2_write(tc, 'DiagnosticWarn')
   else
      idris2_write('Successfully reloaded ' .. file, 'LspSemantic_enumMember')
   end

   return tc
end


local function idris2_command (...)
   local arg = { ... }
   local idriscmd = vim.fn.shellescape(table.concat(arg, ' '))
   local file = vim.fn.expand('%:p')
   return vim.fn.system('idris2 --no-color --find-ipkg ' .. vim.fn.shellescape(file) .. ' --client ' .. idriscmd)
end


-- Get the text near cursor position.
-- It's a refinement of 'expand(<cword>)'
-- to accomodate differences between
-- a (n)vim word and what Idris requires
local function idris2_current_query_object ()
   local word = vim.fn.expand('<cword>')

   -- Cutting off '?' that introduces a hole
   if string.find(word, '^%?') ~= nil then
      word = string.sub(word, 2)
   end

   return word
end


local function idris2_show_type ()
   vim.cmd.write()

   local word = idris2_current_query_object()
   local ty = idris2_command(':t', word)

   idris2_write(ty, 'Comment')
end


local function idris2_trivial_proof_search ()
   local view = vim.fn.winsaveview()

   vim.cmd.write()

   local cline = vim.fn.line('.')
   local word = idris2_current_query_object()
   local result = idris2_command(':ps!', cline, word, '')

   if result ~= '' then
      idris2_write(result, 'DiagnosticWarn')
   else
      vim.cmd.edit()
      -- e  -- move to the end of the word
      vim.fn.winrestview(view)
   end
end


local function idris2_case_split ()
   vim.cmd.write()

   local view = vim.fn.winsaveview()
   local curr_line = vim.fn.line('.')
   local curr_col = vim.fn.col('.')
   local word = vim.fn.expand('<cword>')
   local result = idris2_command(':cs!', curr_line, curr_col, word)

   if result ~= '' then
      idris2_write(result, 'DiagnosticWarn')
   else
      vim.cmd.edit()
      vim.fn.winrestview(view)
   end
end


local function idris2_on_attach (client)
   local map = vim.keymap.set
   -- Prefix for noremap, suffix for normal mode
   local nmapn = function (key, command, description)
      map('n', key, command, { noremap = true, desc = description })
   end

   local general = require('idris2')
   local hover = require('idris2.hover')
   local action = require('idris2.code_action')

   nmapn('<localleader>j', vim.lsp.buf.definition, 'Buffer definition')
   nmapn('<cr>', hover.close_split, 'Close split')
   nmapn('<localleader>t', function ()
      hover.open_split()
      vim.lsp.buf.hover()
   end, 'Open split + Hover')
   nmapn('<localleader>y', function ()
      hover.close_split()
      vim.lsp.buf.hover()
   end, 'Close split + Hover')
   nmapn('<localleader>h', vim.lsp.buf.signature_help, 'Signature help')

   nmapn('<localleader>i', general.show_implicits, 'Show implicits')
   nmapn('<localleader>I', general.hide_implicits, 'Hide implicits')
   nmapn('<localleader>n', general.full_namespace, 'Show namespace')
   nmapn('<localleader>N', general.hide_namespace, 'Hide namespace')

   nmapn('<localleader>c', action.case_split, 'Split case')
   nmapn('<localleader>mc', action.make_case, 'Make case')
   nmapn('<localleader>mw', action.make_with, 'Make with')
   nmapn('<localleader>l', action.make_lemma, 'Make lemma')
   nmapn('<localleader>d', action.add_clause, 'Add clause')
   nmapn('<localleader>g', action.generate_def, 'Generate definition')
   nmapn('<localleader>p', action.refine_hole, 'Refine hole')
   nmapn('<localleader>P', action.expr_search, 'Search expression')
   nmapn('<localleader>O', action.intro, 'Introduction')

   nmapn('<localleader><Tab>', require('idris2.browse').browse, 'Browse')
   nmapn('<localleader>e', require('idris2.repl').evaluate, 'Evaluate (REPL)')
   nmapn('<localleader>v', require('idris2.metavars').request_all, 'Request all')

   nmapn('<localleader>x', vim.diagnostic.goto_next, 'Goto next')
   nmapn('<localleader>z', vim.diagnostic.goto_prev, 'Goto prev')

   nmapn('<localleader>r', idris2_reload, 'Brady\'s Reload')
   nmapn('<localleader>o', idris2_trivial_proof_search, 'Brady\'s Trivial Proof Search')
   -- nmapn('<localleader>t', idris2_show_type, 'Brady\'s Show Type')
   nmapn('<localleader>T', idris2_show_type, 'Brady\'s Show Type')
   -- nmapn('<localleader>c', idris2_case_split, 'Brady\'s Case Split')
   nmapn('<localleader>C', idris2_case_split, 'Brady\'s Case Split')
end

-- Idris2 LS is a somewhat Idris2 compiler
-- which is connected via LSP. So, to make it
-- analyze, we must save the file and the compiler
-- will see the changes
local function save_hook (action)
   vim.cmd.write({ mods = { silent = true } })
end


return {
   client = {
      hover = {
         use_split = false,
         split_size = 0,
         auto_resize_split = true,
         with_history = false,
         split_position = 'bottom',
      },
   },

   -- Options passed to lspconfig idris2 configuration
   server = {
      on_attach = idris2_on_attach,
      init_options = {
         logFile = '/dev/null',
         logSeverity = 'Info',
      },
   },

   -- Function to execute after a code action is performed
   code_action_post_hook = save_hook,

   -- Set default highlight groups for semantic tokens
   -- use_default_semantic_hl_groups = false,
}
