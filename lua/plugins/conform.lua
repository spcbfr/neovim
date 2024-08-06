return {
  'stevearc/conform.nvim',
  dependencies = { 'mason.nvim' },

  opts = {
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      sh = { 'shfmt' },
      zsh = { 'shfmt' },
      php = { 'pint', ignore_errors = true },
      blade = { 'blade-formatter' },
      markdown = { 'prettierd' },
      javascript = { 'biome' },
      typescript = { 'biome' },
      json = { 'biome' },
      css = { 'prettierd' },
      yaml = { 'prettierd' },
      vue = { 'prettierd' },
    },
  },
}
