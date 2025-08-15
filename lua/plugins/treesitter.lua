return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
      vim.filetype.add {
        extension = {
          mdx = 'mdx',
        },
      }

      vim.filetype.add {
        extension = { rasi = 'rasi', rofi = 'rasi', wofi = 'rasi' },
        filename = {
          ['vifmrc'] = 'vim',
        },
        pattern = {
          ['.*/waybar/config'] = 'jsonc',
          ['.*/mako/config'] = 'dosini',
          ['.*/kitty/.+%.conf'] = 'bash',
          ['.*/hypr/.+%.conf'] = 'hyprlang',
          ['%.env%.[%w_.-]+'] = 'sh',
        },
      }

      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      vim.treesitter.language.register('markdown', 'mdx')

      ---@diagnostic disable-next-line: inject-field
      parser_config.blade = {
        install_info = {
          url = 'https://github.com/EmranMR/tree-sitter-blade',
          files = { 'src/parser.c' },
          branch = 'main',
        },
        filetype = 'blade',
      }
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'bash', 'todotxt', 'org', 'c', 'html', 'tsx', 'lua', 'markdown', 'vim', 'vimdoc' },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        textobjects = {

          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },

          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['aa'] = '@parameter.outer',
              ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
              ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
            },
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            include_surrounding_whitespace = true,
          },
        },
      }
    end,
  },
}
