return {

  'onsails/lspkind.nvim',
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { 'j-hui/fidget.nvim', opts = {} },
    },
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          -- fix double $ sign in php code
          vim.api.nvim_create_autocmd('FileType', {
            pattern = 'php',
            callback = function()
              vim.opt.iskeyword:append '$'
            end,
          })

          require('mason-tool-installer').setup { ensure_installed = ensure_installed }
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

      local servers = {
        phpactor = {
          enabled = true,
        },

        lua_ls = {
          settings = {
            Lua = {
              hint = { enable = true, arrayIndex = 'Disable' },
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                -- Tells lua_ls where to find all the Lua files that you have loaded
                -- for your neovim configuration.
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
                -- If lua_ls is really slow on your computer, you can try this instead:
                -- library = { vim.env.VIMRUNTIME },
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format lua code
      })

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            require('lspconfig')[server_name].setup {
              cmd = server.cmd,
              settings = server.settings,
              filetypes = server.filetypes,
              capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {}),
            }
          end,
        },
      }
    end,
  },
}
