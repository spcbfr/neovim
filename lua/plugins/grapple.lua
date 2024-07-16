return {
  'cbochs/grapple.nvim',
  opts = {
    scope = 'git', -- also try out "git_branch"
  },
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = 'Grapple',
  keys = {
    { '<leader>m', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
    { '<leader>k', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple toggle tags' },
    { '<leader>1', '<cmd>Grapple select index=1<cr>', desc = 'Grapple select 1' },
    { '<leader>2', '<cmd>Grapple select index=2<cr>', desc = 'Grapple select 2' },
    { '<leader>3', '<cmd>Grapple select index=3<cr>', desc = 'Grapple select 3' },
    { '<leader>4', '<cmd>Grapple select index=4<cr>', desc = 'Grapple select 4' },
  },
}
