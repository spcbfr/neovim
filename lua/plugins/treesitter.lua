return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      vim.filetype.add {
        extension = { mdx = 'mdx', rasi = 'rasi', rofi = 'rasi', wofi = 'rasi' },
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
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        textobjects = {
          move = {
            enable = true,
            goto_next_start = {
              [']f'] = '@function.outer',
            },
            goto_previous_start = {
              ['[f'] = '@function.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>an'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>ap'] = '@parameter.inner',
            },
          },

          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@call.outer',
              ['ic'] = '@call.inner',
              ['aa'] = '@parameter.outer',
            },
            include_surrounding_whitespace = true,
          },
        },
      }
    end,
  },
}
