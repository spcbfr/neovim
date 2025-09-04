return {
    -- cmd = { 'lua-language-server' },
    -- filetypes = { 'lua' },
    -- root_markers = {
    --     '.luarc.json',
    --     '.luarc.jsonc',
    --     '.luacheckrc',
    --     '.stylua.toml',
    --     'stylua.toml',
    --     'selene.toml',
    --     'selene.yml',
    --     '.git',
    -- },
    settings = {
        Lua = {
            hint = { enable = true, arrayIndex = 'Disable' },
            runtime = { version = 'LuaJIT' },
            workspace = {
                checkThirdParty = false,
                -- Tells lua_ls where to find all the Lua files that you have loaded
                library = { vim.env.VIMRUNTIME },
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            diagnostics = { disable = { 'missing-fields' } },
        },
    },
}
