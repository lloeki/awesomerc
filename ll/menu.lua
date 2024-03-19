local awful = require('awful')
local menubar = require('menubar')

local awesome_menu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "lock", "xautolock -locknow" },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end }
}

local menu = awful.menu({ items = {
                        { "terminal", terminal },
                        { "web", browser },
                        { "mail", mail },
                        { "music", terminal .. " -geometry 55x35 -e ncmpc" },
                        { "awesome", awesome_menu }
                    }
                })

menubar.utils.terminal = terminal

return { menu=menu }
