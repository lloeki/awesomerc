local awful = require('awful')

tags = {}
awful.screen.connect_for_each_screen(function(s)
    tags[s] = awful.tag({ '1', '2', '3', '4', '5', '6', '7', '8', '9' }, s, awful.layout.layouts[1])
end)

return tags
