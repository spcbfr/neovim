require 'settings'
require 'mappings'

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Installing the Lazy.nvim™ Package Manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- this reads files in ./lua/plugins/*.lua
-- and merges them into the main plugin spec
require('lazy').setup('plugins', {
  change_detection = {
    enabled = false,
  },
})

require 'lspconf'
vim.cmd 'colorscheme tokyonight'
vim.o.background = 'dark'

-- vim: ts=2 sts=2 sw=2 et
