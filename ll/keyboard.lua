local awful = require('awful')
--local tags  = require('ll/tags')
--local menubar = require("menubar")

local home = os.getenv('HOME')
local screenshots_dir = home .. '/screenshots'
local screenshot_pattern = '%Y-%m-%d %H:%M:%S $wx$h'

local globalkeys = awful.util.table.join(
    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, 'Shift'   }, "p", function ()
        awful.spawn.easy_async({"scrot", screenshots_dir .. '/' .. screenshot_pattern .. '.png'}, function(stdout, stderr, reason, exit_code)
            naughty.notify({ title="Screenshot saved!", text=stdout })
        end)
    end),

    -- TODO: notify { run = }
    -- TODO: display thumb in notification
    awful.key({ modkey, 'Control'   }, "p", function ()
        awful.spawn.easy_async({"scrot", '--select', screenshots_dir .. '/' .. screenshot_pattern .. '.png'}, function(stdout, stderr, reason, exit_code)
            naughty.notify({ title="Screenshot saved!", text=stdout })
        end)
    end),
    awful.key({ modkey, 'Mod1'   }, "p", function ()
        awful.spawn.easy_async({"scrot", '--focused', screenshots_dir .. '/' .. screenshot_pattern .. '.png'}, function(stdout, stderr, reason, exit_code)
            naughty.notify({ title="Screenshot saved!", text=stdout })
        end)
    end),

    awful.key({ modkey,           }, "r", function () awful.spawn("rofi -show drun") end,
              {description = "open desktop app", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "r", function () awful.spawn("rofi -show run") end,
              {description = "run command", group = "launcher"}),

    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"})

--  awful.key({ modkey }, "p", function() menubar.show() end,
--            {description = "show the menubar", group = "launcher"})
)

local clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
 -- awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
 -- awful.key({ modkey,           }, "n",
 --     function (c)
 --         -- The client currently has the input focus, so it cannot be
 --         -- minimized, since minimized clients can't have the focus.
 --         c.minimized = true
 --     end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
local keynumber = 0
awful.screen.connect_for_each_screen(function(s)
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

local clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)

return {
    global = {
        keys = globalkeys
    },
    client = {
        keys = clientkeys,
        buttons = clientbuttons
    },
}
