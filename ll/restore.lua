local awful = require('awful')

floatgeoms = {}

client.connect_signal("unmanage", function(c)
    floatgeoms[c.window] = nil
end)

-- Save float layout windows geometry

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

awful.screen.connect_for_each_screen(function(s)
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
end)
