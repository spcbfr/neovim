-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`

return {

  -- Lua

  {
    'olivercederborg/poimandres.nvim',
  },
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
