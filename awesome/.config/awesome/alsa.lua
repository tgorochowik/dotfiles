
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2013, Luke Bonham                     
      * (c) 2010, Adrian C. <anrxc@sysphere.org>  
                                                  
--]]

local wibox           = require("wibox")

local io              = { popen  = io.popen }
local string          = { match  = string.match }

local setmetatable    = setmetatable

-- ALSA volume
-- lain.widgets.alsa
local alsa = {}

local function worker(args)
    local args     = args or {}
    local timeout  = args.timeout or 5
    local channel  = args.channel or "Master"
    local settings = args.settings or function() end

    alsa.widget = wibox.widget.textbox('')

    function alsa.update()
        local f = assert(io.popen('amixer -M get ' .. channel))
        local mixer = f:read("*a")
        f:close()

        volume_now = {}

        volume_now.level, volume_now.status = string.match(mixer, "([%d]+)%%.*%[([%l]*)")

        if volume_now.level == nil
        then
            volume_now.level  = "0"
            volume_now.status = "off"
        end

        if volume_now.status == ""
        then
            if volume_now.level == "0"
            then
                volume_now.status = "off"
            else
                volume_now.status = "on"
            end
        end

        widget = alsa.widget
        settings()
    end

    localtimer = {}
    function newtimer(timeout, fun, nostart)
        localtimer = timer({ timeout = timeout })
        localtimer:connect_signal("timeout", fun)
        localtimer:start()
        if not nostart then
            localtimer:emit_signal("timeout")
        end
    end

    newtimer(timeout, alsa.update)

    return setmetatable(alsa, { __index = alsa.widget })
end

return setmetatable(alsa, { __call = function(_, ...) return worker(...) end })
