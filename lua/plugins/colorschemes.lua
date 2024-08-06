-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`

return {

  {
    'ellisonleao/gruvbox.nvim',
  },
  {
    'rose-pine/neovim',
  },
  {
    'svrana/neosolarized.nvim',
    lazy = false,
    dependencies = { 'tjdevries/colorbuddy.nvim', tag = 'v1.0.0' },
    init = function()
      -- require('colorbuddy').colorscheme ''
    end,
  },
  { 'savq/melange-nvim' },
  {
    'zenbones-theme/zenbones.nvim',
    dependencies = {
      'rktjmp/lush.nvim',
    },
  },
  -- Install without configuration
  { 'projekt0n/github-nvim-theme' },

  -- Or with configuration
  {
    'projekt0n/github-nvim-theme',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      style = 'night',
      light_style = 'day',
      lualine_bold = true,
    },
    -- init = function()
    --   vim.cmd 'colorscheme tokyonight'
    -- end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
  },

  {
    dir = '~/.config/nvim/lua/_color',
    lazy = false,
    priority = 900,
    init = function()
      require('_color').setup()
    end,
  },
}
