local beautiful = require('beautiful')
local awful = require('awful')
local gears = require('gears')

beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")

terminal = "urxvt"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
browser = "chromium"
mail = "thunderbird"

modkey = "Mod4"

layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.max
}

if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end

return {
    terminal=terminal,
    editor=editor,
    editor_cmd=editor_cmd,
    browser=browser,
    mail=mail,
    layouts=layouts
}
