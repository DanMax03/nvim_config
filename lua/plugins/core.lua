return {
   {
      'rebelot/kanagawa.nvim',
      lazy = false,  -- ensuring installation during startup
      priority = 1000,  -- ensuring it goes first
      opts = {
         theme = "wave"
      },
      config = function()
         vim.cmd("colorscheme kanagawa")
      end
   },
   {
      'nvim-treesitter/nvim-treesitter',
      lazy = false,
      build = ':TSUpdate',  -- ensure that parsers are always updated
      config = function()
         local configs = require('nvim-treesitter.configs')

         configs.setup({
            ensure_installed = {
               "c", "lua", "vim", "vimdoc", "query", "python", "bash", "markdown", "markdown_inline",  -- basic parsers, to override neovim-ones
               "asm", "cmake", "cpp", "cuda", "dockerfile", "haskell", "html", "jsonc", "latex", "luadoc", "make"
            },
            sync_install = false,  -- do not install parsers synchronously
            highlight = {enable = true}
         })
      end,
   },
   {
      'folke/which-key.nvim',
      event = 'VeryLazy',
      init = function()
         vim.o.timeout = true
         vim.o.timeoutlen = 300
      end,
      opts = {
         plugins = { spelling = true },
         defaults = {
            mode = { 'n', 'v' },
         },
      },
      config = function(_, opts)
         local wk = require('which-key')
         wk.setup(opts)
         wk.register(opts.defaults)
      end,
   },
   {
      'nvim-neo-tree/neo-tree.nvim',
      branch = 'v3.x',
      dependencies = {
         'nvim-lua/plenary.nvim',
         'nvim-tree/nvim-web-devicons',
         'MunifTanjim/nui.nvim'
      },
      init = function()
         vim.api.nvim_create_autocmd('BufEnter', {
            group = vim.api.nvim_create_augroup('NeoTreeInit', {clear = true}),
            callback = function()
               local f = vim.fn.expand('%:p')

               if vim.fn.isdirectory(f) ~= 0 then
                  vim.cmd('Neotree current dir=' .. f)
                  vim.api.nvim_clear_autocmds({group = 'NeoTreeInit'})
               end
            end,
         })
      end,
      opts = {
         filesystem = {
            hijack_netrw_behavior = 'open_current'
         }
      },
      cmd = 'Neotree',
   },
   {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.5',
      dependencies = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep' },
      cmd = 'Telescope',
      keys = {
         { '<leader>ff', '<cmd>Telescope find_files<cr>',
           mode = 'n', desc = 'Telescope find files' },
         { '<leader>fg', '<cmd>Telescope live_grep<cr>',
           mode = 'n', desc = 'Telescope live grep' },
      }
   },
   {
      'ThePrimeagen/harpoon',
      dependencies = { 'nvim-lua/plenary.nvim' }
   },
   {
      'mbbill/undotree',
      init = function()
         local g = vim.g

         g.undotree_WindowLayout = 2
         g.undotree_SetFocusWhenToggle = 1
      end,
      keys = {
         { '<leader>ut', '<cmd>UndotreeToggle<cr>',
           mode = 'n', desc = 'Toggle Undotree' },
      },
   },
   {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      config = false,
      init = function()
         local g = vim.g

         g.lsp_zero_extend_cmp = 0
         g.lsp_zero_extend_lspconfig = 0
      end,
   },
   {
      'williamboman/mason.nvim',
      lazy = false,
      config = true,
   },
   {
      'hrsh7th/nvim-cmp',
      dependencies = {
         'L3MON4D3/LuaSnip'
      },
      event = 'InsertEnter',
      config = function()
         local lsp_zero = require('lsp-zero')

         lsp_zero.extend_cmp()
      end,
   },
   {
      'neovim/nvim-lspconfig',
      dependencies = {
         'hrsh7th/cmp-nvim-lsp',
         'williamboman/mason-lspconfig.nvim',
      },
      event = { 'BufReadPre', 'BufNewFile' },
      cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
      config = function()
         -- This is where all the LSP shenanigans will live
         local lsp_zero = require('lsp-zero')

         lsp_zero.extend_lspconfig()

         lsp_zero.on_attach(function(client, bufnr)
            lsp_zero.default_keymaps({ buffer = bufnr })
         end)

         -- Configuring LSs
         require('mason-lspconfig').setup({
            ensure_installed = {},
            handlers = {
               lsp_zero.default_setup,
               lua_ls = function()
                  local lua_opts = lsp_zero.nvim_lua_ls()

                  require('lspconfig').lua_ls.setup(lua_opts)
               end,
            }
         })
      end
   },
}
