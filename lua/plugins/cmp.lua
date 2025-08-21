return {

  'saghen/blink.cmp',

  -- use a release tag to download pre-built binaries
  version = 'v1.*',
  -- build = 'cargo build --release',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'default' },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    completion = {
      -- menu = { auto_show = function(ctx) return ctx.mode ~= 'cmdline' end },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
      ghost_text = {
        enabled = true,
      },
    },

    signature = { enabled = true },
  },
  opts_extend = { 'sources.default' },
}
