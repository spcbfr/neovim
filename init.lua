-- require('vim._extui').enable({})
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
vim.opt.winblend       = 5     -- floating windows are somewhat transparent
vim.opt.pumblend       = 5     -- pum stands for popup menu
vim.opt.pumheight      = 10    -- pum stands for popup menu

vim.opt.scrolloff      = 10

vim.o.list             = true
vim.opt.listchars      = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.confirm        = true
vim.o.statuscolumn     = "%s%l "

vim.g.mapleader        = " "

-- ========== Plugin Agnostic Keymaps =========
vim.keymap.set({ 'n', 'x' }, 'gy', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('n', 'gp', '"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set('x', 'gp', '"+P', { desc = 'Paste from system clipboard' })
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>', { desc = 'clear search highlights on escape' })

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    callback = function()
        vim.hl.on_yank()
    end,
})


-- =========== helper functions ==============
function _(str)
    return "https://github.com/" .. str
end

function packadd(name)
    return vim.cmd.packadd { name, bang = true }
end

function configure(name, config)
    packadd(name)
    if (config == true) then
        require(name).setup()
    elseif (type(config) == "table") then
        require(name).setup(config)
    elseif (type(config) == "function") then
        config()
    end
end

function loader(p)
    if (not p.spec.data) then
        packadd(p.spec.name)
    elseif (p.spec.data.events) then
        local group = vim.api.nvim_create_augroup("lazy", { clear = true })

        vim.api.nvim_create_autocmd(p.spec.data.events, {
            group = group,
            callback = function()
                configure(p.spec.name, p.spec.data.config)
            end
        })
    else
        configure(p.spec.name, p.spec.data.config)
    end
end

vim.pack.add { _ "folke/tokyonight.nvim" }
vim.cmd.colorscheme "tokyonight-night"

-- =========== snacks ==============
vim.pack.add { _ 'folke/snacks.nvim' }

local Snacks = require('snacks')
Snacks.setup {
    notifier = {},
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
vim.keymap.set('n', '<leader>sh', function() Snacks.picker.help() end, { desc = "Search Files" })
vim.keymap.set('n', '<leader>sa', function() Snacks.picker.autocmds() end, { desc = "Search Autocmds" })
vim.keymap.set('n', '<leader>?', function() Snacks.picker.recent() end, { desc = "Recent" })


-- =========== mini.nvim ==============
vim.pack.add { _ 'echasnovski/mini.nvim' }
require('mini.icons').setup()
require('mini.statusline').setup()
local miniclue = require('mini.clue')
miniclue.setup({
    triggers = {
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        { mode = 'n', keys = '[' },
        { mode = 'n', keys = ']' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
    },
    clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.square_brackets(),
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
        { mode = 'n', keys = 'gx', desc = "xdg-open uri under cursor" }
    },
    window = {
        delay = 500,
        config = {
            width = "auto"
        }
    }
})
require('mini.diff').setup({
    view = { style = "sign", signs = { add = "+", change = "~", delete = "-" } }
})
vim.api.nvim_set_hl(0, 'MiniDiffSignChange', { fg = "#d694ff" })
require('mini.pairs').setup({
    skip_ts = { 'string' },
    skip_unbalanced = true,
    markdown = true,
})
require('mini.surround').setup()

-- ========== Explorer ===========
vim.pack.add { _ 'stevearc/oil.nvim' }
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

vim.pack.add { _ 'nvim-lua/plenary.nvim' }
vim.pack.add { _ 'NeogitOrg/neogit' }
vim.keymap.set('n', '<leader>ng', require('neogit').open, { desc = "Neogit" })

-- =========== Holy LSP ============
vim.pack.add({
    {
        src = _ 'neovim/nvim-lspconfig',
        name = "lspconfig",
        data = { config = function() require('lspconfig') end }
    },
    {
        src = _ 'j-hui/fidget.nvim',
        name = "fidget",
        data = { config = true }
    },
    {
        src = _ 'mason-org/mason.nvim',
        name = "mason",
        data = { config = true }
    },
    {
        src = _ 'stevearc/conform.nvim',
        name = "conform",
    },
    {
        src = _ 'saghen/blink.cmp',
        version = vim.version.range('v1.*'),
        data = {
            events = "LspAttach",
            config = { completion = { documentation = { auto_show = true } } },
        }
    },
}, { load = loader })

require('conform').setup({
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = 'fallback',
    },
    formatters_by_ft = {
        lua = { 'stylua' },
        sh = { 'shfmt' },
        zsh = { 'shfmt' },
        php = { 'pint', ignore_errors = true },
        blade = { 'blade-formatter' },
        markdown = { 'prettierd' },
        javascript = { 'biome' },
        typescript = { 'biome' },
        json = { 'biome' },
        css = { 'prettierd' },
        yaml = { 'prettierd' },
        vue = { 'prettierd' },
    },

})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client:supports_method('textDocument/foldingRange') then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
        end

        vim.lsp.inlay_hint.enable(false)

        vim.keymap.set('n', '<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = "toggle inlay hints" })

        vim.diagnostic.config({
            float = {
                header = "You can fix this",
                source = "if_many",
            },
            virtual_text = {
                current_line = true,
                source = "if_many",
                severity = vim.diagnostic.severity.WARN
            },
            virtual_lines = {
                source = "if_many",
                severity = vim.diagnostic.severity.ERROR
            }
        })
        vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float)
    end
})

vim.lsp.enable({ 'lua_ls', 'phpactor', 'gopls' })
