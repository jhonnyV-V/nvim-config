require("mason").setup()
require("mason-nvim-dap").setup()
local lsp = require("lsp-zero").preset()
local lspconfig = require("lspconfig")
local servers = {
  'tsserver',
  'eslint',
  'lua_ls',
  'cmake',
  'golangci_lint_ls',
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
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "T", function() vim.lsp.buf.type_definition() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
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

local server_config = {
    ["doesItThrow"] = {
        throwStatementSeverity = "Hint",
        functionThrowSeverity = "Hint",
        callToThrowSeverity = "Hint",
        callToImportedThrowSeverity = "Hint",
        includeTryStatementThrows = false,
        maxNumberOfProblems = 10000
    }
}

-- Setup doesItThrow
if not lspconfig.configs.does_it_throw_server then
    lspconfig.configs.does_it_throw_server = {
        default_config = {
            cmd = {"does-it-throw-lsp", "--stdio"},
            filetypes = {"typescript", "javascript"},
            root_dir = function(fname)
                return vim.fn.getcwd()
            end
        }
    }
end

lspconfig.does_it_throw_server.setup {
    on_init = function(client)
        client.config.settings = server_config
    end,
		-- important to set this up so that the server can find your desired settings
    handlers = {
        ["workspace/configuration"] = function(_, params, _, _)
            local configurations = {}
            for _, item in ipairs(params.items) do
                if item.section then
                    table.insert(configurations, server_config[item.section])
                end
            end
            return configurations
        end
    }
}
