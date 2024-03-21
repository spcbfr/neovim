return {
  'cbochs/grapple.nvim',
  opts = {
    scope = 'git', -- also try out "git_branch"
  },
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = 'Grapple',
  keys = {
    { '<leader>m', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
    {
      '<leader>M',
      function()
        local Oil = require 'oil'
        local filename = Oil.get_cursor_entry().name
        local directory = Oil.get_current_dir()

        local Grapple = require 'grapple'
        local Path = require 'grapple.path'
        Grapple.toggle { path = Path.join(directory, filename) }
      end,
      desc = 'Grapple tag under cursor',
    },
    { '<leader>k', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple toggle tags' },
    { '<leader>K', '<cmd>Grapple toggle_scopes<cr>', desc = 'Grapple toggle scopes' },
    { '<leader>j', '<cmd>Grapple cycle forward<cr>', desc = 'Grapple cycle forward' },
    { '<leader>J', '<cmd>Grapple cycle backward<cr>', desc = 'Grapple cycle backward' },
    { '<leader>1', '<cmd>Grapple select index=1<cr>', desc = 'Grapple select 1' },
    { '<leader>2', '<cmd>Grapple select index=2<cr>', desc = 'Grapple select 2' },
    { '<leader>3', '<cmd>Grapple select index=3<cr>', desc = 'Grapple select 3' },
    { '<leader>4', '<cmd>Grapple select index=4<cr>', desc = 'Grapple select 4' },
  },
}
