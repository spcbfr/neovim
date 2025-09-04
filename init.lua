vim.opt.number         = true
vim.opt.relativenumber = true

vim.opt.undofile       = true
vim.o.spelloptions     = "camel"

vim.opt.cursorline     = true -- highlight cursorline
vim.opt.ignorecase     = true -- search is case insensitive
vim.opt.smartcase      = true -- unless an uppercase letter is in the prompt

vim.opt.breakindent    = true -- wrapped lines preserve their indenting
vim.opt.tabstop        = 4    -- how long is a tab
vim.opt.shiftwidth     = 0    -- use tabstop value
vim.opt.inccommand     = "split"
vim.opt.expandtab      = true
vim.opt.showmode       = false -- mini.statusline already takes care of that
vim.opt.infercase      = true
vim.opt.scrolloff      = 10
vim.opt.textwidth      = 80
vim.opt.mousemodel     = "extend"

vim.opt.completeopt    = 'menuone,noselect,fuzzy'

vim.opt.splitright     = true  -- vertical splits open rightwise
vim.opt.splitbelow     = true  -- horizontal ones open bottomwise

vim.opt.signcolumn     = "yes" -- always show sign column to avoid view being changed
vim.opt.winborder      = "rounded"
vim.opt.pumheight      = 10
vim.opt.laststatus     = 3

vim.opt.foldmethod     = "indent"
vim.opt.foldlevel      = 20

vim.o.list             = true
vim.opt.listchars      = { tab = '» ', trail = '·', nbsp = '␣' }

vim.g.mapleader        = " "
vim.opt.confirm        = true

vim.opt.wildmenu       = true
vim.opt.wildmode       = "noselect:lastused,full"
if vim.fn.executable "rg" == 1 then
    vim.opt.grepprg = "rg --vimgrep --smart-case"
end

vim.opt.iskeyword:append('-') -- consider dash-seperated words as singular words

vim.keymap.set('n', 'zl', 'za')
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>')
vim.api.nvim_create_user_command('Pack', function(_)
    vim.pack.update()
end, { desc = "update packages" })
vim.api.nvim_create_user_command('WipeReg', function(_)
    for i = 34, 122 do
        vim.fn.setreg(vim.fn.nr2char(i), nil)
    end
end, { desc = "Wipe all registers" })


vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    callback = function()
        vim.hl.on_yank()
    end,
})
vim.filetype.add({
    pattern = {
        [".*%.blade%.php"] = "blade",
    },
})

if vim.fn.executable "fd" == 1 then
    function _G.RgFindFiles(cmdarg, _cmdcomplete)
        local fnames = vim.fn.systemlist('fd --color never --type file')
        if #cmdarg == 0 then
            return fnames
        else
            return vim.fn.matchfuzzy(fnames, cmdarg)
        end
    end

    vim.o.findfunc = 'v:lua.RgFindFiles'
end

vim.api.nvim_create_autocmd('CmdlineChanged', {
    pattern = { '*' },
    group = vim.api.nvim_create_augroup('CmdlineAutocompletion', { clear = true }),
    desc = "Autocomplete on keypress for specified functions",
    callback = function(_)
        local cmd = vim.fn.split(vim.fn.getcmdline(), ' ')[1]
        local allowed_cmds = { "find", 'hi', 'sfind', 'sf', 'tabfind', 'tabf', "help", 'h', 'fin', 'lua' }

        if (vim.tbl_contains(allowed_cmds, cmd)) then
            vim.fn.wildtrigger()
        end
    end
})

-- require('vim._extui').enable({})

vim.pack.add {
    "https://github.com/vague2k/vague.nvim",
    "https://github.com/folke/tokyonight.nvim",
    "https://github.com/rebelot/kanagawa.nvim",
    'https://github.com/yorik1984/newpaper.nvim',
    'https://github.com/miikanissi/modus-themes.nvim'
}

vim.cmd.colorscheme "kanagawa"

require('miscellaneous')
require("statusline")

vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }
require('nvim-treesitter.configs').setup {
    ensure_installed = { 'php', 'html', 'blade', 'lua', 'typst' },
    highlight = { enable = true },
    indent = { enable = true }
}

vim.pack.add {
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/chomosuke/typst-preview.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/mason-org/mason.nvim',
}

require('lspconfig')
require('mason').setup()
require('formatting')
require('completion')

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client:supports_method('textDocument/foldingRange') then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
        end

        vim.lsp.document_color.enable(true, 0, { style = "virtual" })

        vim.lsp.inlay_hint.enable(false)

        vim.keymap.set('n', '<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = "toggle inlay hints" })

        vim.diagnostic.config({
            severity_sort = true,
            virtual_text = {
                prefix = "●",
                current_line = true,
                source = "if_many",
                severity = vim.diagnostic.severity.ERROR
            },
        })
        vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float)
    end
})

-- automatically enable LSP servers in lsp/
local lsp_config_paths = vim.split(vim.fn.glob(vim.fn.stdpath('config') .. '/lsp/*'), '\n', { trimempty = true })
local servers = vim.tbl_map(function(path)
    local split = vim.split(path, '/')
    local filename = split[#split]
    local server = vim.split(filename, '.', { plain = true })[1]
    return server
end, lsp_config_paths)

vim.lsp.enable(servers)
