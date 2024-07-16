return {
  {
    'adalessa/laravel.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'tpope/vim-dotenv',
      'MunifTanjim/nui.nvim',
      'nvimtools/none-ls.nvim',
    },
    cmd = { 'Sail', 'Artisan', 'Composer', 'Npm', 'Yarn', 'Laravel' },
    keys = {
      { '<leader>la', ':Laravel artisan<cr>' },
      { '<leader>lr', ':Laravel routes<cr>' },
      { '<leader>lm', ':Laravel related<cr>' },
    },
    event = { 'VeryLazy' },
    config = function()
      require('laravel').setup()
      vim.filetype.add {
        pattern = {
          ['.*%.blade%.php'] = 'blade',
        },
      }
    end,
  },
  -- Lua
  {
    'ricardoramirezr/blade-nav.nvim',
    requires = {
      'hrsh7th/nvim-cmp', -- if using nvim-cmp
    },
    ft = { 'blade', 'php' },
  },
}
