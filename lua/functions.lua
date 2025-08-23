function _(str)
    return "https://github.com/" .. str
end

function packadd(name)
    return vim.cmd.packadd {name, bang=true}
end
local group = vim.api.nvim_create_augroup("plugins", {})

function loader(p)
    
    if (p.spec.data) then
        local data = p.spec.data
        local configured = false

        if(data.event) then
            vim.api.nvim_create_autocmd(data.event, {
                group = group,
                callback = function ()
                    packadd(p.spec.name)
                    if(data.config and not configured) then
                        data.config()
                        configured = true
                    end
                end
            })
        end

        if (data.opts) then 
            packadd(p.spec.name)
            if (data.opts == true) then
                require(p.spec.name).setup()
            else
                require(p.spec.name).setup(data.opts)
            end
        end

        if (data.config and not configured) then
            data.config()
            configured = true
        end
    end

    packadd(p.spec.name)
end
