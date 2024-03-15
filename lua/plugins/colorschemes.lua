-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`

return {

  { 'rose-pine/neovim' },
  {
    'catppuccin/nvim',
    name = 'catppuccin',

    priority = 1000,
    lazy = false,
    init = function()
      vim.cmd 'colorscheme catppuccin-mocha'
    end,
  },
}
