return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = ' ', right = ' ' },
        section_separators = { left = ' ', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = {
          {
            'mode',
            color = { gui = 'bold' },
            fmt = function(str)
              return str:sub(1, 4)
            end,
          },
        },
        lualine_b = {
          {
            'filename',
            padding = { left = 0, right = 1 },
            cond = function()
              return vim.fn.empty(vim.fn.expand '%:t') ~= 1
            end,
          },
        },
        lualine_c = {
          { 'grapple', padding = { left = 1, right = 0 } },

          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ' },
            -- diagnostics_color = {
            --   error = 'ErrorMsg',
            --   warn = 'WarningMsg',
            --   info = { 'DiagnosticsInfo' },
            -- },
          },
        },
        lualine_x = {
          {
            'diff',
            -- colored = true, -- Displays a colored diff status if set to true
            -- diff_color = {
            --   -- Same color values as the general color option can be used here.
            --   added = 'DiffAdd', -- Changes the diff's added color
            --   modified = 'DiffChange', -- Changes the diff's modified color
            --   removed = 'DiffRemoved', -- Changes the diff's removed color you
            -- },
            symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
            -- source = nil, -- A function that works as a data source for diff.
            -- -- It must return a table as such:
            -- --   { added = add_count, modified = modified_count, removed = removed_count }
            cond = function()
              return vim.fn.winwidth(0) > 80
            end,
            -- -- or nil on failure. count <= 0 won't be displayed.
          },
          'filetype',
        },
        lualine_y = { --[[ 'progress' ]]
        },
        lualine_z = { --[[ 'location' ]]
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
