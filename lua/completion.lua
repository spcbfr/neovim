vim.pack.add({
    "https://github.com/onsails/lspkind.nvim",
    {
        src = 'https://github.com/saghen/blink.cmp',
        version = vim.version.range('v1.*')
    }
})
require('lspkind').setup()


require('blink.cmp').setup({
    signature = { enabled = true },
    completion = {
        list = { selection = { preselect = false, auto_insert = true } },
        accept = {
            auto_brackets = {
                enabled = true
            },
        },
        documentation = {
            window = {
                border = "single"
            },
            auto_show = true,
            auto_show_delay_ms = 400
        },
        menu = {
            border = "none",
            draw = {
                padding = { 0, 1 }, -- padding only on right side
                components = {
                    kind_icon = {
                        text = function(ctx) return ' ' .. ctx.kind_icon .. ctx.icon_gap .. ' ' end
                    }
                }
            }
        }
    }
})
if (vim.g.color_names == "tokyonight-night") then
    vim.api.nvim_set_hl(0, 'BlinkCmpMenu', { bg = "#242635" })
end
