--[[
          .---.     .---.
         ( -o- )---( -o- )
         ;-...-`   `-...-;
        /                 \
       /                   \
      | /_               _\ |   Lazy configs, am I right?
      \`'.`'"--.....--"'`.'`/
       \  '.   `._.`   .'  /
    _.-''.  `-.,___,.-`  .''-._
   `--._  `'-._______.-'`  _.--`
   jgs  /                 \
       /.-'`\   .'.   /`'-.\
      `      '.'   '.'
--]]

return {

  { 'j-hui/fidget.nvim', opts = {} },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())
      vim.lsp.enable { 'lua_ls', 'phpactor', 'gopls' }
    end,
  },

  { 'williamboman/mason.nvim', opts = {} },
  {
    'nanozuki/tabby.nvim',
    ---@type TabbyConfig
    opts = {},
  },
  { 'wakatime/vim-wakatime' },
  {
    'MagicDuck/grug-far.nvim',
    opts = {},
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'night',
    },
  },
  {
    'stevearc/oil.nvim',
    opts = {
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        natural_order = 'fast',
        is_always_hidden = function(name, _)
          return name == '..' or name == '.git'
        end,
      },
    },
    dependencies = { 'echasnovski/mini.icons' },
    lazy = false,

    keys = {
      { '-', '<CMD>Oil<CR>', desc = 'Open Parent Directory' },
    },
  },
  {
    'chomosuke/typst-preview.nvim',
    lazy = false, -- or ft = 'typst'
    version = '1.*',
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
    },
    config = true,
    cmd = 'Neogit',
    keys = {
      { '<leader>ng', '<cmd>:Neogit<cr>', desc = 'Open [N]eo[G]it' },
    },
  },

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      { '<leader>dq', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics' },
    },
  },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('which-key').setup {
        plugins = {
          spelling = {
            enabled = false,
          },
        },
        win = {
          no_overlap = false,
          height = { min = 4, max = 25 },
        },
      }

      -- Document existing key chains
      require('which-key').add {
        {
          { 'gx', hidden = true },
          { '<leader>d', group = 'Diagnostics' },
          { 'gr', group = 'LSP' },
          { '<leader>s', group = 'Search' },
        },
      }
    end,
  },

  { 'NMAC427/guess-indent.nvim', opts = {} },
}
