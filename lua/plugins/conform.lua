return {
  'stevearc/conform.nvim',
  dependencies = { 'mason.nvim' },
  cmd = 'ConformInfo',

  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { lsp_fallback = true }
      end,
      mode = { 'n', 'v' },
      desc = 'Format File',
    },
    {
      '<leader>cF',
      function()
        require('conform').format { formatters = { 'injected' } }
      end,
      mode = { 'n', 'v' },
      desc = '[F]ormat injected langs',
    },
  },
  opts = function()
    local opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        sh = { 'shfmt' },
        zsh = { 'shfmt' },
        php = { 'pint' },
        blade = { 'blade-formatter' },
        markdown = { 'prettierd' },
        javascript = { 'biome' },
        typescript = { 'biome' },
        json = { 'biome' },
        css = { 'prettierd' },
        yaml = { 'prettierd' },
        vue = { 'prettierd' },
      },
      -- The options you set here will be merged with the builtin formatters.
      -- You can also define any custom formatters here.
      formatters = {
        injected = { options = { ignore_errors = true } },
        pint = function(bufnr)
          return { command = require('conform.util').find_executable({
            './vendor/bin/pint',
          }, 'pint') }
        end,
      },
    }
    return opts
  end,
}
