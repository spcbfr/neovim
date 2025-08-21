-- Clear search highlight on <esc>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit insert mode with jk
vim.keymap.set('i', 'jk', '<esc>')

vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })

-- absolutely useless
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Show diagnostic [E]rror messages' })

-- Doom Emacs-inspired keymaps
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { noremap = true, silent = true, desc = 'delete buffer' })
vim.keymap.set('n', '<leader>bs', ':w<CR>', { noremap = true, silent = true, desc = 'save buffer' })

-- More ergonomic
vim.keymap.set('n', 'zl', 'za')
vim.keymap.set('n', 'z+', 'za')
vim.keymap.set('t', '<c-\\>', '<c-\\><c-n>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')
