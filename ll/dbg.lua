local naughty = require('naughty')

local function table_keys(table)
    local keys = {}
    local n = 0
    for k, v in pairs(var) do
        n = n + 1
        keys[n] = k
    end
    return keys
end

local function to_text(var)
    if type(var) == 'table' then
        text = "{ "
        for k, v in pairs(var) do
            text = text .. k .. ":" .. to_text(v) .. " "
        end
        text = text .. "}"
    else
        text = var
    end
    return text
end

local function notify(vars)
    local text = ""
    for i=1, #vars do text = text .. "| " .. to_text(vars[i]) .. "\n" end
    naughty.notify({ text = string.sub(text, 1, -2), timeout = 10 })
end

return { notify=notify }
