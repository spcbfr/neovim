return {
  -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for install instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires special font.
    --  If you already have a Nerd Font, or terminal set up with fallback fonts
    --  you can enable this
    { 'nvim-tree/nvim-web-devicons' },
  },

  -- Lazy load telescope when the `Telescope` command is executed.
  cmd = 'Telescope',
  -- And also lazy load telescope on these key mappings.
  -- For more builtin function, see `:help telescope.builtin`.
  keys = {
    { '<leader>sh', require('telescope.builtin').help_tags, desc = '[S]earch [H]elp' },
    { '<leader>sk', require('telescope.builtin').keymaps, desc = '[S]earch [K]eymaps' },
    { '<leader>sf', require('telescope.builtin').find_files, desc = '[S]earch [F]iles' },
    { '<leader>ss', require('telescope.builtin').builtin, desc = '[S]earch [S]elect telescope.builtin' },
    { '<leader>sw', require('telescope.builtin').grep_string, desc = '[S]earch current [W]ord' },
    { '<leader>sg', require('telescope.builtin').live_grep, desc = '[S]earch by [G]rep' },
    { '<leader>sd', require('telescope.builtin').diagnostics, desc = '[S]earch [D]iagnostics' },
    { '<leader>sr', require('telescope.builtin').resume, desc = '[S]earch [R]esume' },
    { '<leader>s.', require('telescope.builtin').oldfiles, desc = '[S]earch Recent Files ("." for repeat)' },
    { '<leader><leader>', require('telescope.builtin').buffers, desc = '[ ] Find existing buffers' },

    -- Slightly advanced example of overriding default behavior and theme
    {
      '<leader>/',
      function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end,
      desc = '[/] Fuzzily search in current buffer',
    },
    -- Also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    {
      '<leader>s/',
      function()
        require('telescope.builtin').live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end,
      desc = '[S]earch [/] in Open Files',
    },
    -- Shortcut for searching your neovim configuration files
    {
      '<leader>sn',
      function()
        require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = '[S]earch [N]eovim files',
    },
  },
  config = function()
    -- Two important keymaps to use while in telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    require('telescope').setup {
      defaults = {
        file_ignore_patterns = { 'node_modules', 'vendor' },
        selection_caret = '  ',
        prompt_prefix = '   ',
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
  end,
}
