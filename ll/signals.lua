local naughty = require('naughty')
local beautiful = require('beautiful')
local awful = require('awful')

--local tags = require('ll/tags')

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)

    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

-- Border highlight on focus

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Titlebar for floating windows

--client.connect_signal("manage", function (c, startup)
--
--    -- Add a titlebar if floating layout
--    if (awful.layout.get(c.screen) == awful.layout.suit.floating or awful.client.floating.get(c)) then
--        awful.titlebar.add(c, { modkey = modkey })
--    end
--
--    -- Set titlebar depending on tag layout
--    --c:connect_signal("tagged", function(c, t)
--    --    if awful.layout.get(c.screen) == awful.layout.suit.floating or awful.client.floating.get(c) then
--    --        awful.titlebar.add(c, { modkey = modkey })
--    --    else
--    --        awful.titlebar.remove(c, { modkey = modkey })
--    --    end
--    --end)
--
--    -- Add a titlebar if windows is made floating
--    c:connect_signal("property::floating", function(c)
--        if awful.layout.get(c.screen) == awful.layout.suit.floating or awful.client.floating.get(c) then
--            awful.titlebar.add(c, { modkey = modkey })
--        else
--            awful.titlebar.remove(c, { modkey = modkey })
--        end
--    end)
--end)

-- for s = 1, screen.count() do
--     for t = 1, #tags[s] do
--         mytag = tags[s][t]
--         mytag:connect_signal("property::selected", function(t)
--             clients = t:clients()
--             for c = 1, #clients do
--                 if awful.layout.get(clients[c].screen) == awful.layout.suit.floating or awful.client.floating.get(clients[c]) then
--                     awful.titlebar.add(clients[c], { modkey = modkey })
--                 else
--                     awful.titlebar.remove(clients[c], { modkey = modkey })
--                 end
--             end
--         end)
--     end
-- end


-- Titlebars everywhere for float layout

--for s = 1, screen.count() do
--    for t = 1, #tags[s] do
--        mytag = tags[s][t]
--        mytag:connect_signal("property::layout", function(t)
--            clients = t:clients()
--            for c = 1, #clients do
--                if awful.layout.get(clients[c].screen) == awful.layout.suit.floating or awful.client.floating.get(clients[c]) then
--                    awful.titlebar.add(clients[c], { modkey = modkey })
--                else
--                    awful.titlebar.remove(clients[c], { modkey = modkey })
--                end
--            end
--        end)
--    end
--end
-- Persist float layout windows geometry

floatgeoms = {}

client.connect_signal("unmanage", function(c)
    floatgeoms[c.window] = nil
end)

client.connect_signal("manage", function(c)
    if (awful.layout.get(c.screen) == awful.layout.suit.floating or awful.client.floating.get(c)) then
        floatgeoms[c.window] = c:geometry()

        c:connect_signal("property::geometry", function(c)
            if (awful.layout.get(c.screen) == awful.layout.suit.floating or awful.client.floating.get(c)) then
                floatgeoms[c.window] = c:geometry()
            end
        end)
    end
end)

-- Restore geometry when back on float layout

for s = 1, screen.count() do
    for t = 1, #tags[s] do
        mytag = tags[s][t]
        mytag:connect_signal("property::layout", function(t)
            clients = t:clients()
            for k = 1, #clients do
                c = clients[k]
                if (awful.layout.get(c.screen) == awful.layout.suit.floating or awful.client.floating.get(c)) then
                    c:geometry(floatgeoms[c.window])
                end

            end
        end)
    end
end

-- Prevent windows from going above wibox

client.connect_signal("manage", function(c)
    local geometry = c:geometry()
    if geometry.y < 18+1 then
        geometry.y = 18+1
        c:geometry(geometry)
    end
    c:connect_signal("property::geometry", function(c)
        local geometry = c:geometry()
        if geometry.y < 18+1 then
            geometry.y = 18+1
            c:geometry(geometry)
        end
    end)
end)

-- }}}
