local awful = require('awful')
local menu = require('ll/menu')

root.buttons(awful.util.table.join(
 -- awful.button({ }, 1, function () menu.menu:close() end),
 -- awful.button({ }, 4, awful.tag.viewnext),
 -- awful.button({ }, 5, awful.tag.viewprev),
    awful.button({ }, 3, function () menu.menu:toggle() end)
))
