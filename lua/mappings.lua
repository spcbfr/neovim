--         _,--',   _._.--._____
--  .--.--';_'-.', ";_      _.,-'
-- .'--'.  _.'    {`'-;_ .-.>.'
--       '-:_      )  / `' '=.      Get it? this file is mappings.lua
--         ) >     {_/,     /~)     and this is an ascii art of a map
--         |/               `^ .'

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- local map = function(mode, keys, func, options)
--   vim.keymap.set(mode, keys, func, options)
-- end

local map = vim.keymap.set

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })

-- Doom Emacs-inspired keymaps
map('n', '<leader>bd', ':bd<CR>', { noremap = true, silent = true })
map('n', '<leader>bs', ':w<CR>', { noremap = true, silent = true })
map('n', '<leader>qq', ':xa<CR>', { noremap = true, silent = true })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Exit insert mode with jk
-- Highly Experimental
map('i', 'jk', '<esc>')
