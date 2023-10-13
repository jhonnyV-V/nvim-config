-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use{
    'nvim-treesitter/nvim-treesitter',
    run = function() require("nvim-treesitter.install").update { with_sync = true } end,
  }
  use({
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    requires = { {'nvim-lua/plenary.nvim'} },
  })
  use "folke/tokyonight.nvim"
  use 'ThePrimeagen/harpoon'
  use "mbbill/undotree"
  use "tpope/vim-fugitive"
  use 'tpope/rhubarb'
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      --- Uncomment these if you want to manage LSP servers from neovim
      -- {'williamboman/mason.nvim'},
      -- {'williamboman/mason-lspconfig.nvim'},
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'L3MON4D3/LuaSnip'},
    }
  }
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    'folke/neodev.nvim',
  }
  use 'wakatime/vim-wakatime'
  -- Useful plugin to show you pending keybinds.
  use 'folke/which-key.nvim'
   -- Markdown Preview
  use({
      "iamcco/markdown-preview.nvim",
      run = function()
          vim.fn["mkdp#util#install"]()
      end,
  })
end)
