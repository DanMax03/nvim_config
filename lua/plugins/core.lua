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
      dependencies = { 'nvim-lua/plenary.nvim' }
   },
   {
      'ThePrimeagen/harpoon',
      dependencies = { 'nvim-lua/plenary.nvim' }
   },
   {
      'mbbill/undotree'
   }
}
