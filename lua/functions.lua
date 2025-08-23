function _(str)
    return "https://github.com/" .. str
end

function packadd(name)
    return vim.cmd.packadd {name, bang=true}
end
local group = vim.api.nvim_create_augroup("plugins", {})
function configure(name, config)
    packadd(name)
    if(config == true) then
        require(name).setup()
    elseif(type(config) == "table") then
        require(name).setup(config)
    elseif(type(config) == "function") then
        config()
    end
end

function loader(p)
    if (p.spec.data.events) then
        print("hello")
        local group = vim.api.nvim_create_augroup("lazy" , { clear = true })

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
