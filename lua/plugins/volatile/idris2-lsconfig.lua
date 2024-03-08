local function idris2_on_attach (client)
   local map = vim.keymap.set
   -- Prefix for noremap, suffix for normal mode
   local nmapn = function (key, command, description)
      map('n', key, command, { noremap = true, desc = description })
   end

   local general = require('idris2')
   local hover = require('idris2.hover')
   local action = require('idris2.action')

   nmapn('<LocalLeader>j', vim.lsp.buf.definition, 'Buffer definition')
   nmapn('<cr>', hover.close_split, 'Close split')
   nmapn('<LocalLeader>t', function ()
      hover.open_split()
      vim.lsp.buf.hover()
   end, 'Open split + Hover')
   nmapn('<LocalLeader>y', function ()
      hover.close_split()
      vim.lsp.buf.hover()
   end)
   nmapn('<LocalLeader>h', vim.lsp.buf.signature_help, 'Signature help')

   nmapn('<LocalLeader>i', general.show_implicits, 'Show implicits')
   nmapn('<LocalLeader>I', general.hide_implicits, 'Hide implicits')
   nmapn('<LocalLeader>n', general.full_namespace, 'Show namespace')
   nmapn('<LocalLeader>N', general.hide_namespace, 'Hide namespace')

   nmapn('<LocalLeader>c', action.case_split, 'Split case')
   nmapn('<LocalLeader>mc', action.make_case, 'Make case')
   nmapn('<LocalLeader>mw', action.make_with, 'Make with')
   nmapn('<LocalLeader>l', action.make_lemma, 'Make lemma')
   nmapn('<LocalLeader>d', action.add_clause, 'Add clause')
   nmapn('<LocalLeader>g', action.generate_def, 'Generate definition')
   nmapn('<LocalLeader>p', action.refine_hole, 'Refine hole')
   nmapn('<LocalLeader>P', action.expr_search, 'Search expression')
   nmapn('<LocalLeader>O', action.intro, 'Introduction')

   nmapn('<LocalLeader><Tab>', require('idris2.browse').browse, 'Browse')
   nmapn('<LocalLeader>e', require('idris2.repl').evaluate, 'Evaluate (REPL)')
   nmapn('<LocalLeader>v', require('idris2.metavars').request_all, 'Request all')

   nmapn('<LocalLeader>x', vim.diagnostic.goto_next, 'Goto next')
   nmapn('<LocalLeader>z', vim.diagnostic.goto_prev, 'Goto prev')
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
