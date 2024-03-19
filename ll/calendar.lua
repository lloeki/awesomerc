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
    remove_calendar() -- TODO: calendar notification replace_text
    offset = save_offset + inc_offset
    local datespec = os.date("*t")
    local months = datespec.year * 12 + datespec.month - 1 + offset
    local calm = '' .. months % 12 + 1
    local caly = '' .. math.floor(months / 12)
    awful.spawn.easy_async({"cal", "-m", calm, caly}, function(stdout, stderr, reason, exit_code)
      if exit_code > 0 then
          naughty.notify({text = reason .. ' ' .. exit_code .. "\n" .. stderr})
      end

      cal = string.gsub(stdout, "^%s*(.-)%s*$", "%1")
      calendar = naughty.notify({
          text = string.format('<span font_desc="%s">%s</span>', "monospace", cal),
          timeout = 0, hover_timeout = 0.5,
          width = dpi(160),
      })
    end)
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
