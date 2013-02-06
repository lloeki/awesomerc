local awful = require('awful')

tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 'one', 'two', 'three', 'four' }, s, layouts[1])
end
