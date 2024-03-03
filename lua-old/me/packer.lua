
return require("packer").startup(function(use)
  -- Packer can manage itself
  use {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    requires = {
      --- Uncomment these if you want to manage LSP servers from neovim
      -- {"williamboman/mason.nvim"},
      -- {"williamboman/mason-lspconfig.nvim"},
      -- LSP Support
      { "neovim/nvim-lspconfig" },
    }
  }
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
end)
