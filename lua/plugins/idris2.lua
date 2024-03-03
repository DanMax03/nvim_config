-- It is considered that vim.g.is_idris2_setup is true


return {
   'ShinKage/idris2-nvim',
   lazy = false,  -- ensuring installation during startup
   dependencies = {
      'neovim/nvim-lspconfig',
      'MunifTanjim/nui.nvim'
   }
}

