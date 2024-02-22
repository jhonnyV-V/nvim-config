require("mason").setup()
require("mason-nvim-dap").setup()

require("neodev").setup({
  library = {
    plugins = {
      "nvim-dap-ui",
      "telescope.nvim",
      "plenary.nvim",
      "nvim-treesitter"
    },
    enabled = true,
    runtime = true,
    types = true,
  },
})

local lsp = require("lsp-zero").preset('recommended')
local lspconfig = require("lspconfig")
local servers = {
  'tsserver',
  'eslint',
  'lua_ls',
  'cmake',
  'golangci-lint',
  'golangci_lint_ls',
  'gopls',
  'jedi_language_server',
  'stylelint',
  'cssmodules_ls',
  --'tailwindcss',
  'jsonls',
  'html',
  'docker_compose_language_service',
  'zk',
  'yamlls',
  'pyright',
  'clangd',
  handlers = {
    lsp.default_setup,
  },
}
require("mason-lspconfig").setup(servers)

lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim', 'require' }
            }
        }
    }
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
  })
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  vim.keymap.set(
    "n",
    "gd",
    function() vim.lsp.buf.definition() end,
    {
      buffer = bufnr,
      remap = false,
      desc = '[G]o to [D]efinition'
    }
  )
  vim.keymap.set(
    "n",
    "K",
    function() vim.lsp.buf.hover() end,
    {
      buffer = bufnr,
      remap = false,
      desc = 'Lsp Hover'
    }
  )
  vim.keymap.set(
    "n",
    "T",
    function() vim.lsp.buf.type_definition() end,
    {
      buffer = bufnr,
      remap = false,
      desc = '[Type] definition'
    }
  )
  vim.keymap.set(
    "n",
    "<leader>vws",
    function() vim.lsp.buf.workspace_symbol() end,
    {
      buffer = bufnr,
      remap = false,
      desc = 'View [W]orkspace [S]ymbol'
    }
  )
  vim.keymap.set(
    "n",
    "<leader>vd",
    function() vim.diagnostic.open_float() end,
    {
      buffer = bufnr,
      remap = false,
      desc = 'View diagnostics'
    }
  )
  vim.keymap.set(
    "n",
    "[d",
    function() vim.diagnostic.goto_next() end,
    {
      buffer = bufnr,
      remap = false,
      desc = 'Go to next diagnostic'
    }
  )
  vim.keymap.set(
    "n",
    "]d",
    function() vim.diagnostic.goto_prev() end,
    {
      buffer = bufnr,
      remap = false,
      desc = 'Go to previus diagnostic'
    }
  )
  vim.keymap.set(
    "n",
    "<leader>vca",
    function() vim.lsp.buf.code_action() end,
    {
      buffer = bufnr,
      remap = false,
      desc = 'Lsp [C]ode [A]ction'
    }
  )
  vim.keymap.set(
    "n",
    "<leader>vrr",
    function() vim.lsp.buf.references() end,
    {
      buffer = bufnr,
      remap = false,
      desc = 'View [R]eferences'
    }
  )
  vim.keymap.set(
    "n",
    "<leader>vrn",
    function() vim.lsp.buf.rename() end,
    {
      buffer = bufnr,
      remap = false,
      desc = '[R]ename in buffer'
    }
  )
  vim.keymap.set(
    "i",
    "<C-h>",
    function() vim.lsp.buf.signature_help() end,
    {
      buffer = bufnr,
      remap = false,
      desc = "Signature help"

    }
  )
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.cmake.setup({})
lspconfig.golangci_lint_ls.setup({})
--lspconfig.tailwindcss.setup({})
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require'lspconfig'.jsonls.setup {
  capabilities = capabilities,
}
lspconfig.html.setup {
  capabilities = capabilities,
}
--npm i -g vscode-langservers-extracted
lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})
lspconfig.tsserver.setup({})
lspconfig.docker_compose_language_service.setup({})
lspconfig.pyright.setup({})
lspconfig.jedi_language_server.setup({})
lspconfig.clangd.setup({})
lspconfig.cssmodules_ls.setup({})
lspconfig.cssls.setup({
  capabilities = capabilities,
})

