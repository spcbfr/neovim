vim.opt.number         = true
vim.opt.relativenumber = true

vim.opt.undofile       = true

vim.opt.cursorline     = true  -- highlight cursorline
vim.opt.ignorecase     = true  -- search is case insensitive
vim.opt.smartcase      = true  -- unless an uppercase letter is in the prompt

vim.opt.breakindent    = true  -- wrapped lines preserve their indenting
vim.opt.tabstop        = 4     -- how long is a tab
vim.opt.shiftwidth     = 0     -- use tabstop value
vim.opt.expandtab      = true
vim.opt.showmode       = false -- mini.statusline already takes care of that
vim.opt.infercase      = true
vim.opt.completeopt    = 'menuone,noselect'

vim.opt.splitright     = true  -- vertical splits open rightwise
vim.opt.splitbelow     = true  -- horizontal ones open bottomwise

vim.opt.signcolumn     = "yes" -- always show sign column to avoid view being changed
vim.opt.winborder      = "rounded"
vim.opt.winblend       = 5    -- floating windows are somewhat transparent
vim.opt.pumblend       = 5    -- pum stands for popup menu
vim.opt.pumheight      = 10    -- pum stands for popup menu

vim.o.list             = true
vim.opt.listchars      = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.confirm        = true


-- Copy/paste with system clipboard
vim.keymap.set({ 'n', 'x' }, 'gy', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set(  'n',        'gp', '"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set(  'x',        'gp', '"+P', { desc = 'Paste from system clipboard' })

vim.g.mapleader = " "

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    callback = function()
        vim.hl.on_yank()
    end,
})

require('functions') -- helper functions

vim.pack.add { _"folke/tokyonight.nvim" }
vim.cmd.colorscheme "tokyonight-night"

vim.pack.add { _'echasnovski/mini.nvim' }

require('mini.icons').setup()
require('clues')
require('mini.diff').setup({
    view = {
        style = "sign",
    }
})
require('mini.surround').setup()
require('mini.statusline').setup()
require('mini.pairs').setup({
    skip_ts = { 'string' },
    skip_unbalanced = true,
    markdown = true,
})

vim.pack.add { _'stevearc/oil.nvim'}
vim.pack.add { _'nvim-lua/plenary.nvim'}
vim.pack.add { _'NeogitOrg/neogit'}
vim.keymap.set('n', '<leader>ng', require('neogit').open, {desc = "Neogit"})

packadd('nohlsearch')

require("oil").setup {
    skip_confirm_for_simple_edits = true,
    view_options = {
        show_hidden = true,
        natural_order = 'fast',
        is_always_hidden = function(name, _)
            return name == '..' or name == '.git'
        end,
    },
}

vim.keymap.set('n', '-', ":Oil<cr>")

vim.pack.add { _'neovim/nvim-lspconfig'}
vim.pack.add { _'mason-org/mason.nvim'}

vim.pack.add {{ src= _'saghen/blink.cmp', version=vim.version.range('v1.*')}}

require("mason").setup()
require("blink.cmp").setup({
    completion = { documentation = { auto_show = true } },
})


vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client:supports_method('textDocument/foldingRange') then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
        end

        vim.lsp.inlay_hint.enable(true)

        vim.keymap.set('n', '<leader>th', function ()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, {desc = "toggle inlay hints"})

        vim.diagnostic.config({
            virtual_text = true
        })
    end
})

vim.lsp.enable({'lua_ls', 'phpactor', 'gopls'})

