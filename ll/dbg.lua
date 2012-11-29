Dbg = {}

function Dbg.table_keys(table)
    local keys = {}
    local n = 0
    for k, v in pairs(var) do
        n = n + 1
        keys[n] = k
    end
    return keys
end

function Dbg.to_text(var)
    if type(var) == 'table' then
        text = "{ "
        for k, v in pairs(var) do
            text = text .. k .. ":" .. Dbg.to_text(v) .. " "
        end
        text = text .. "}"
    else
        text = var
    end
    return text
end

function Dbg.naughty(vars)
    local text = ""
    for i=1, #vars do text = text .. "| " .. Dbg.to_text(vars[i]) .. "\n" end
    naughty.notify({ text = string.sub(text, 1, -2), timeout = 10 })
end

dbg = Dbg.naughty
