vim.g.mapleader = ' '
vim.o.winborder = 'shadow'
vim.opt.hlsearch = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.shiftwidth = 0

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Each pane having it's own statusline makes the editor too busy
-- instead let's use a single global statusline
vim.o.laststatus = 3

-- Keep the cursor a block in insert moderate
-- vim.opt.guicursor = 'i:block'
vim.o.spelllang = 'en,fr'

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Disable mouse right click
vim.o.mousemodel = 'extend'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- check help page
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See :help 'list'
--  and :help 'listchars'
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

vim.diagnostic.config {
  severity_sort = true,
  float = { header = 'You can fix this!', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = { current_line = true },
}
