local awful = require('awful')
local naughty = require('naughty')

local calendar = nil
local offset = 0

local function remove_calendar()
    if calendar ~= nil then
        naughty.destroy(calendar)
        calendar = nil
        offset = 0
    end
end

local function add_calendar(inc_offset)
    local save_offset = offset
    remove_calendar()
    offset = save_offset + inc_offset
    local datespec = os.date("*t")
    datespec = datespec.year * 12 + datespec.month - 1 + offset
    datespec = (datespec % 12 + 1) .. " " .. math.floor(datespec / 12)
    local cal = awful.util.pread("cal -m " .. datespec)
    cal = string.gsub(cal, "^%s*(.-)%s*$", "%1")
    calendar = naughty.notify({
        text = string.format('<span font_desc="%s">%s</span>', "monospace", cal),
        timeout = 0, hover_timeout = 0.5,
        width = 160,
    })
end

local function add_to_clock(clock)
    clock:connect_signal("mouse::enter", function()
        add_calendar(0)
    end)

    clock:connect_signal("mouse::leave", remove_calendar)

    clock:buttons(awful.util.table.join(
        awful.button({ }, 4, function()
            add_calendar(-1)
        end),
        awful.button({ }, 5, function()
            add_calendar(1)
        end)
    ))
end

return { add_to_clock=add_to_clock }
