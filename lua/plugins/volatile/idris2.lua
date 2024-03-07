-- It is considered that vim.g.is_idris2_setup is true


return {
   {
      'ShinKage/idris2-nvim',
      dependencies = {
         'neovim/nvim-lspconfig',
         'MunifTanjim/nui.nvim'
      }
      ft = "idr"
   }
}

