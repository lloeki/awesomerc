local awful = require('awful')
local menubar = require('menubar')

local awesome_menu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "lock", "xscreensaver-command -lock" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

local menu = awful.menu({ items = {
                        { "awesome", awesome_menu },
                        { "terminal", terminal },
                        { "web", browser },
                        { "mail", mail },
                        { "music", terminal .. " -geometry 55x35 -e ncmpc" }
                    }
                })

menubar.utils.terminal = terminal

return { menu=menu }
