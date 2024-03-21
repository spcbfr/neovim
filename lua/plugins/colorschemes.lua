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
    opts = {
      style = 'night',
      light_style = 'day',
      lualine_bold = true,
    },
    init = function()
      vim.cmd 'colorscheme tokyonight'
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
  },
}
