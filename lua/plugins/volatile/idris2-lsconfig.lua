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
   end)
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
      on_attach = idris2_on_attach
   },

   -- Function to execute after a code action is performed
   -- code_action_post_hook = save_hook,

   -- Set default highlight groups for semantic tokens
   -- use_default_semantic_hl_groups = false,
}
