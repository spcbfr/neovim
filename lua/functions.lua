function _(str)
    return "https://github.com/" .. str
end

function packadd(name)
    return vim.cmd.packadd {name, bang=true}
end
local group = vim.api.nvim_create_augroup("plugins", {})

function loader(spec)
    local data = spec.data
    local configured = false
    print(spec)

    if(data.event) then
        vim.api.nvim_create_autocmd(data.event, {
            group = group,
            callback = function ()
                packadd(spec.name)
                if(data.config and not configured) then
                    data.config()
                    configured = true
                end
            end
        })
    end

    if (data.opts) then 
        packadd(spec.name)
        if (data.opts == true) then
            require(spec.name).setup()
        else
            require(spec.name).setup(data.opts)
        end
    end

    if (data.config and not configured) then
        data.config()
        configured = true
    end
end
