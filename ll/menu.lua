-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "lock", "xscreensaver-command -lock" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = {
                                { "awesome", myawesomemenu },
                                { "terminal", terminal },
                                { "web browser", browser },
                                { "mail", mail },
                                { "music", terminal .. " ncmpc" }
                            }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}
