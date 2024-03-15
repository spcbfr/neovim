--[[
                        _________
                       / ======= \
                      / __________\
       Yusuf's       | ___________ |     free pal3stine!
    Neovim Config    | | -       | |
                     | |         | |
                     | |_________| |
                     \=____________/
                     / """"""""""" \    distant cousin 
                    / ::::::::::::: \    of kickstart.nvim
                   (_________________)

--]]

require 'settings'
require 'mappings'
require 'autocmds'

-- Installing the Lazy.nvim™ Package Manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- this reads files in ./lua/plugins/*.lua
-- and merges them into the main plugin spec
-- to add a new plugin create a new file in lua/plugins/
require('lazy').setup('plugins', {
  change_detection = {
    enabled = false,
  },
})

-- vim: ts=2 sts=2 sw=2 et
