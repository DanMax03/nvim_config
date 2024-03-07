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
      keys = {
         { '<leader>ff', '<cmd>Telescope find_files<cr>', mode = 'n' },
         { '<leader>fg', '<cmd>Telescope live_grep<cr>', mode = 'n' }
      }
   },
   {
      'nvim-neo-tree/neo-tree.nvim',
      branch = 'v3.x',
      dependencies = {
         'nvim-lua/plenary.nvim',
         'nvim-tree/nvim-web-devicons',
         'MunifTanjim/nui.nvim'
      }
   },
   {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.5',
      dependencies = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep' },
      cmd = "Telescope"
   },
   {
      'ThePrimeagen/harpoon',
      dependencies = { 'nvim-lua/plenary.nvim' }
   },
   {
      'mbbill/undotree'
   }
}
