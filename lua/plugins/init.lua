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

  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth',

  {
    'windwp/nvim-autopairs',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    event = 'insertEnter',
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'

      ---@diagnostic disable-next-line: undefined-field
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup()
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
      'nvim-telescope/telescope.nvim',
    },
    config = true,
    cmd = 'Neogit',
    keys = {
      { '<leader>ng', '<cmd>:Neogit<cr>', desc = 'Open [N]eo[G]it' },
    },
  },

  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
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
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      vim.keymap.set('n', '<leader>dq', function()
        require('trouble').toggle()
      end)
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      icons = true,
      signs = {
        error = '',
        warning = '',
        hint = '',
        information = '',
        other = '',
      },
    },
  },

  -- NOTE: Plugins can also be configured to run lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VeryLazy'
  --
  -- which loads which-key after all the UI elements are loaded. Events can be
  -- normal autocommands events (:help autocomd-events).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy', -- Sets the loading event to 'VeryLazy'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]parenthen
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        icons_enabled = true,
        component_separators = '',
        section_separators = '',
      },
    },
  },
}
