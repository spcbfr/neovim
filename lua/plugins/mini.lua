return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.surround').setup()
    require('mini.statusline').setup()
    require('mini.sessions').setup {}

    require('mini.icons').setup {
      filetype = {
        dotenv = { glyph = '', hl = 'MiniIconsYellow' },
      },
    }

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
}
