-- Standard awesome library
local gears           = require("gears")
local awful           = require("awful")
require("awful.autofocus")

-- Theme handling library
local wibox           = require("wibox")
local beautiful       = require("beautiful")

-- Notification library
local naughty         = require("naughty")
local menubar         = require("menubar")

ll = {}
require('ll.errors')
dbg = require('ll/dbg')
require('ll.notifications')
require('ll.vars')
require('ll.tags')

require('ll.menu')
require('ll.wibox')
require('ll.mouse')
require('ll.keyboard')
require('ll.rules')
require('ll.signals')
