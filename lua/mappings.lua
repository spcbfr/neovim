--         _,--',   _._.--._____
--  .--.--';_'-.', ";_      _.,-'
-- .'--'.  _.'    {`'-;_ .-.>.'
--       '-:_      )  / `' '=.      Get it? this file is mappings.lua
--         ) >     {_/,     /~)     and this is an ascii art of a map
--         |/               `^ .'

local map = vim.keymap.set

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '[d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })

-- Doom Emacs-inspired keymaps
map('n', '<leader>bd', ':bd<CR>', { noremap = true, silent = true, desc = 'delete buffer' })
map('n', '<leader>bs', ':w<CR>', { noremap = true, silent = true, desc = 'save buffer' })
map('n', '<leader>qq', ':xa<CR>', { noremap = true, silent = true, desc = 'close neovim' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>')
map('n', '<C-l>', '<C-w><C-l>')
map('n', '<C-j>', '<C-w><C-j>')
map('n', '<C-k>', '<C-w><C-k>')

-- Exit insert mode with jk
map('i', 'jk', '<esc>')
