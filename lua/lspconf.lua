require 'lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

-- These options get merged with lspconfig's defaults
vim.lsp.config.phpactor = {
  capabilities = capabilities,
  init_options = {
    -- ['language_server_worse_reflection.inlay_hints.enable'] = true,
  },
}

vim.lsp.config.lua_ls = {
  capabilities = capabilities,
  settings = {
    Lua = {
      hint = { enable = true, arrayIndex = 'Disable' },
      runtime = { version = 'LuaJIT' },
      workspace = {
        checkThirdParty = false,
        -- Tells lua_ls where to find all the Lua files that you have loaded
        library = { vim.env.VIMRUNTIME },
      },
      -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      diagnostics = { disable = { 'missing-fields' } },
    },
  },
}
vim.lsp.config.gopls = {
  capabilities = capabilities,
  settings = {
    gopls = {
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}

vim.lsp.enable { 'lua_ls', 'phpactor', 'gopls' }
vim.lsp.inlay_hint.enable(true)
