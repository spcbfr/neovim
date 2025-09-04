vim.pack.add {
    'https://github.com/folke/snacks.nvim',
    "https://github.com/folke/which-key.nvim",
    'https://github.com/nvim-mini/mini.nvim',
    { src = 'https://github.com/cbochs/grapple.nvim', name = "grapple" },
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/NeogitOrg/neogit'
}

require('mini.icons').setup()
require('mini.pairs').setup({
    skip_ts = { 'string' },
    modes = { insert = true, command = true, terminal = true },
    skip_unbalanced = true,
    markdown = true,
})
require('mini.surround').setup()
require('mini.diff').setup({
    view = { style = "sign", signs = { add = "+", change = "~", delete = "-" } }
})
vim.api.nvim_set_hl(0, 'MiniDiffSignChange', { fg = "#e99e59" })
local wk = require('which-key')
wk.setup()
wk.add({
    { 'gx', desc = "xdg-open uri under cursor" },
    { 'gr', desc = "LSP" }
})

local Snacks = require('snacks')
Snacks.setup {
    notifier = {},
    image = {
        convert = { notify = false }
    },
    math = { enabled = false },
    statuscolumn = {},
    picker = {
        win = {
            input = {
                keys = { ["<Esc>"] = { "close", mode = { "n", "i" } }, }
            }
        }
    },
    indent = {},
}
vim.keymap.set('n', '<leader>sf', function() Snacks.picker.files() end, { desc = "Search Files" })
vim.keymap.set('n', '<leader>sh', function() Snacks.picker.help() end, { desc = "Search Help" })
vim.keymap.set('n', '<leader>sa', function() Snacks.picker.autocmds() end, { desc = "Search Autocmds" })
vim.keymap.set('n', '<leader>?', function() Snacks.picker.recent() end, { desc = "Recent" })
vim.keymap.set('n', '<leader>sH', function() Snacks.picker.highlights() end, { desc = "Search Highlight Groups" })
vim.keymap.set('n', '<leader>sg', function() Snacks.picker.grep() end, { desc = "Grep Search Project" })

local grapple = require('grapple')
grapple.setup({ scope = "git" })
vim.keymap.set('n', '<leader>m', grapple.toggle, { desc = "toggle tag" })
vim.keymap.set('n', '<leader>k', grapple.toggle_tags, { desc = "open tags window" })
vim.keymap.set('n', '<leader>1', ":Grapple select index=1<cr>", { desc = "Go to tag 1", silent = true })
vim.keymap.set('n', '<leader>2', ":Grapple select index=2<cr>", { desc = "Go to tag 2", silent = true })
vim.keymap.set('n', '<leader>3', ":Grapple select index=3<cr>", { desc = "Go to tag 3", silent = true })
vim.keymap.set('n', '<leader>4', ":Grapple select index=4<cr>", { desc = "Go to tag 4", silent = true })

require("oil").setup {
    skip_confirm_for_simple_edits = true,
    keymaps = {
        ['<leader>x'] = {
            desc = "Run command on file under cursor",
            callback = function()
                local file = require('oil').get_cursor_entry().name
                vim.ui.input({ prompt = "Command: " }, function(input)
                    if (input) then vim.cmd('!' .. input .. " " .. file) end
                end)
            end

        },
    },
    view_options = {
        show_hidden = true,
        natural_order = 'fast',
        is_always_hidden = function(name, _)
            return name == '..' or name == '.git'
        end,
    },
}
vim.keymap.set('n', '-', ":Oil<cr>", { silent = true })
vim.keymap.set('n', '<leader>ng', require('neogit').open, { desc = "Neogit" })
