-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`

return {

  {
    'ellisonleao/gruvbox.nvim',
  },
  {
    'rose-pine/neovim',
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    lazy = false,
    init = function()
      vim.cmd 'colorscheme tokyonight-night'
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
  },
}
