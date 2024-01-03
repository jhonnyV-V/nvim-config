-- This file can be loaded by calling `lua require("plugins")` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"
  use {
    "nvim-treesitter/nvim-treesitter",
    run = function() require("nvim-treesitter.install").update { with_sync = true } end,
  }
  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    requires = { { "nvim-lua/plenary.nvim" } },
  })
  use "folke/tokyonight.nvim"
  use "ThePrimeagen/harpoon"
  use "mbbill/undotree"
  use "tpope/vim-fugitive"
  use {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    requires = {
      --- Uncomment these if you want to manage LSP servers from neovim
      -- {"williamboman/mason.nvim"},
      -- {"williamboman/mason-lspconfig.nvim"},
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "L3MON4D3/LuaSnip" },
    }
  }
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "folke/neodev.nvim",
  }
  use "wakatime/vim-wakatime"
  -- Useful plugin to show you pending keybinds.
  use "folke/which-key.nvim"
  -- Markdown Preview
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  })
  use "voldikss/vim-floaterm"
  use "eandrju/cellular-automaton.nvim"
  use "ThePrimeagen/vim-be-good"
  use "ThePrimeagen/vim-with-me"
  use "rcarriga/nvim-dap-ui"
  use({
    "mfussenegger/nvim-dap",
    requires = {
      -- Creates a beautiful debugger UI
      "rcarriga/nvim-dap-ui",

      -- Installs the debug adapters for you
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",

      -- Add your own debuggers here
      "leoluz/nvim-dap-go",
    },
  })
  use "theHamsta/nvim-dap-virtual-text"
  use({
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
    end,
  })
  use ({
    'alanfortlink/blackjack.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  })
end)
