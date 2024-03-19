local beautiful = require('beautiful')
local awful = require('awful')
local gears = require('gears')

local themes_path = require("gears.filesystem").get_configuration_dir() .. "themes/"
beautiful.init(themes_path .. "zenburn/theme.lua")

-- terminal = "alacritty"
terminal = "kitty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
browser = "firefox"
-- browser = "chromium"
mail = "thunderbird"

modkey = "Mod4"

layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.max
}

dpi = require("beautiful.xresources").apply_dpi

-- TODO: obsolete
-- if beautiful.wallpaper then
--     for s = 1, screen.count() do
--         gears.wallpaper.maximized(beautiful.wallpaper, s, true)
--     end
-- end

return {
    terminal=terminal,
    editor=editor,
    editor_cmd=editor_cmd,
    browser=browser,
    mail=mail,
    layouts=layouts
}
