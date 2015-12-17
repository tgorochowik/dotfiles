-- Standard awesome library
local gears     = require("gears")
local awful     = require("awful")
awful.rules     = require("awful.rules")
require("awful.autofocus")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local menubar   = require("menubar")

-- slightly modified lain plugins
local calendar  = require("calendar")
local alsa      = require("alsa")
local bat       = require("bat")


-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart applications
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

run_once("unclutter")

-- beautiful init
beautiful.init("~/.config/awesome/theme.lua")

-- {{{ Variable definitions
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"
altkey     = "Mod1"

local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.fit(beautiful.wallpaper, s, black)
    end
end
-- }}}

---- {{{ Tags
 tags = {
  main = {
    names  = { "term", "www", "float", "rand", "remote" },
    layout = { awful.layout.suit.tile, awful.layout.suit.tile.top, awful.layout.suit.floating, awful.layout.suit.tile, awful.layout.suit.tile }
  },
  additional = {
    names  = { "monitor", "reader", "ssh",},
    layout = { awful.layout.suit.tile, awful.layout.suit.tile, awful.layout.suit.tile }
  }
 }
 if screen.count() == 2 then
   tags[1] = awful.tag(tags.additional.names, 1, tags.additional.layout)
   tags[2] = awful.tag(tags.main.names, 2, tags.main.layout)
 else
   for s = 1, screen.count() do
       tags[s] = awful.tag(tags.main.names, s, tags.main.layout)
   end
 end
 -- }}}

-- {{{ Wibox
-- Create a textclock widget
--mytextclock = awful.widget.textclock()
mytextclock = awful.widget.textclock(" %a %b %d, %H:%M:%S", 1)

calendar:attach(mytextclock, { font_size = 8 })

sep = wibox.widget.imagebox()
sep:set_image(beautiful.separator)


--gmailw = widget({ type = "textbox" })
gmailw = wibox.widget.textbox()
gmailw:set_text("0")
mailicon = wibox.widget.imagebox()
mailicon:set_image(beautiful.widget_mail)

mail_update=function()
      local c = os.getenv("HOME") .. "/.local/bin/gmailcheck"
      local f = io.popen(c)
      local d = f:read("*all")

      gmailw:set_text(d)

      if tonumber(d) > 0 then
        mailicon:set_image(beautiful.widget_mail_on)
      else
        mailicon:set_image(beautiful.widget_mail)
      end

      f:close()
    end

-- click to spawn mail in browser
mailicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function()
        awful.util.spawn("/usr/bin/chromium gmail.com")
    end),
    awful.button({ }, 3, function()
        mail_update()
    end)
 ))
local gtimer= timer({ timeout = 59 })
gtimer:connect_signal("timeout", function()
  mail_update()
end)

gtimer:start()

-- ALSA volume
volicon = wibox.widget.imagebox(beautiful.widget_vol)
volumewidget = alsa({
    settings = function()
        if volume_now.status == "off" then
            volicon:set_image(beautiful.widget_vol_mute)
        elseif tonumber(volume_now.level) == 0 then
            volicon:set_image(beautiful.widget_vol_no)
        elseif tonumber(volume_now.level) <= 50 then
            volicon:set_image(beautiful.widget_vol_low)
        else
            volicon:set_image(beautiful.widget_vol)
        end

        widget:set_text(" " .. volume_now.level .. "% ")
    end
})

-- Battery
baticon = wibox.widget.imagebox(beautiful.widget_battery)
batwidget = bat({
    settings = function()
        if bat_now.perc == "N/A" then
            widget:set_markup(" AC ")
            baticon:set_image(beautiful.widget_ac)
            return
        elseif tonumber(bat_now.perc) <= 5 then
            baticon:set_image(beautiful.widget_battery_empty)
        elseif tonumber(bat_now.perc) <= 15 then
            baticon:set_image(beautiful.widget_battery_low)
        else
            baticon:set_image(beautiful.widget_battery)
        end
        widget:set_markup(" " .. bat_now.perc .. "% ")
    end
})

-- Thermal monitor using sensors cmd
core_temp = wibox.widget.textbox()
core_temp:set_text(" - ")
core_icon = wibox.widget.imagebox()
core_icon:set_image(beautiful.widget_temp)

core_update=function()
      local f = io.popen("sensors | sed -n -e \'s/.*+\\(.* \\)(.*/\\1/p\'")
      local d = f:read("*all")

      d = d:gsub("\n", "")
      d = d:gsub("%s+$", "")

      core_temp:set_text(d)

      f:close()
    end

core_temp:buttons(awful.util.table.join(
    awful.button({ }, 3, function()
        core_update()
    end)
 ))

local ctimer= timer({ timeout = 223 })
ctimer:connect_signal("timeout", function()
  core_update()
end)

ctimer:start()

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag)
                    --awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    --awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    --left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])
    left_layout:add(sep)

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    --if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(sep)
    right_layout:add(mailicon)
    right_layout:add(gmailw)
    right_layout:add(sep)
    right_layout:add(core_icon)
    right_layout:add(core_temp)
    right_layout:add(sep)
    right_layout:add(volicon)
    right_layout:add(volumewidget)
    right_layout:add(sep)
    right_layout:add(baticon)
    right_layout:add(batwidget)
    right_layout:add(sep)
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

---- {{{ Mouse bindings
--root.buttons(awful.util.table.join(
--    awful.button({ }, 3, function () mymainmenu:toggle() end),
--    awful.button({ }, 4, awful.tag.viewnext),
--    awful.button({ }, 5, awful.tag.viewprev)
--))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({                   },
        "XF86Display",
        function()
            awful.util.spawn_with_shell("~/.config/awesome/scripts/monitor.sh")
        end ),
    --multimedia keys
    awful.key({                   },
        "XF86AudioRaiseVolume",
        function()
            awful.util.spawn("amixer -q set Master 1%+")
            volumewidget.update()
        end ),
    awful.key({                   },
        "XF86AudioLowerVolume",
        function()
            awful.util.spawn("amixer -q set Master 1%-")
            volumewidget.update()
        end ),
    awful.key({                   },
        "XF86AudioMute",
        function()
            awful.util.spawn("amixer -q set Master playback toggle")
            volumewidget.update()
        end ),
    awful.key({ modkey            },
        "Print",
        function()
            awful.util.spawn_with_shell('scrot ~/shots/'..os.date("%Y-%m-%d-%H%M%S")..'.png')
        end ),
    awful.key({},
        "Print",
        function()
            awful.util.spawn_with_shell('import ~/shots/'..os.date("%Y-%m-%d-%H%M%S")..'.png')
        end ),
    awful.key({                   },
        "XF86HomePage",
        function()
            awful.util.spawn("chromium")
        end ),
    awful.key({                   },
        "XF86Mail",
        function()
            awful.util.spawn("chromium gmail.com")
        end ),
    awful.key({                   },
        "XF86Calculator",
        function()
            awful.util.spawn(terminal.." -e python")
        end ),
    awful.key({                   },
        "XF86ScreenSaver",
        function()
            awful.util.spawn_with_shell("slock")
        end ),
--------------------------------------------------
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    -- ALSA volume control
    awful.key({ altkey }, "Up",
        function ()
            awful.util.spawn("amixer -q set Master 1%+")
            volumewidget.update()
        end),
    awful.key({ altkey }, "Down",
        function ()
            awful.util.spawn("amixer -q set Master 1%-")
            volumewidget.update()
        end),
    awful.key({ altkey }, "m",
        function ()
            awful.util.spawn("amixer -q set Master playback toggle")
            volumewidget.update()
        end),
    awful.key({ altkey, "Control" }, "m",
        function ()
            awful.util.spawn("amixer -q set Master playback 100%")
            volumewidget.update()
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- utils
    awful.key({ altkey,           }, "c",      function () calendar:show(7) end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),


    awful.key({ modkey,           }, "w",     function () awful.util.spawn("nautilus")    end),
    awful.key({ altkey,           }, "w",     function () awful.util.spawn(terminal.." -e vifm")  end),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber))
end

if screen.count() == 2 then
  globalkeys = awful.util.table.join(globalkeys,
  awful.key({modkey,            }, "F1",     function () awful.screen.focus(2) end),
  awful.key({modkey,            }, "F2",     function () awful.screen.focus(1) end),
  awful.key({ modkey,   "Shift" }, "F1",
    function ()
      if client.focus then
        awful.client.movetotag(tags[2][awful.tag.getidx(awful.tag.selected(2))])
        --awful.screen.focus(2)
      end
    end),
  awful.key({ modkey,   "Shift" }, "F2",
    function ()
      if client.focus then
        awful.client.movetotag(tags[1][awful.tag.getidx(awful.tag.selected(1))])
        --awful.screen.focus(1)
      end
    end))
end

-- Bind all key numbers to tags.
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

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "URxvt" },
      properties = { opacity = 0.95  } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "Wine" },
      properties = { floating = true} },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    { rule = { class = "Exe" },
      properties = { floating = true } },
    { rule = { class = "Frame" },
      properties = { floating = true } },
    { rule = { class = "Chromium" },
      properties = { tag = tags[screen.count()][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local title = awful.titlebar.widget.titlewidget(c)
        title:buttons(awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                ))

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(title)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
