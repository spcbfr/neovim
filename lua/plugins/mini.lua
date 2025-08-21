return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.surround').setup()
      require('mini.statusline').setup()

      -- require('mini.ai').setup { n_lines = 500 }

      require('mini.sessions').setup {}
      vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')

      require('mini.pairs').setup {
        modes = { insert = true, command = true, terminal = false },
        -- skip autopair when next character is one of these
        skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
        -- skip autopair when the cursor is inside these treesitter nodes
        skip_ts = { 'string' },
        -- skip autopair when next character is closing pair
        -- and there are more closing pairs than opening pairs
        skip_unbalanced = true,
        -- better deal with markdown code blocks
        markdown = true,
      }
    end,
  },

  {
    'echasnovski/mini.icons',
    lazy = true,
    opts = {
      filetype = {
        dotenv = { glyph = '', hl = 'MiniIconsYellow' },
      },
    },
    specs = {
      { 'nvim-tree/nvim-web-devicons', enabled = false, optional = true },
    },
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },
}
