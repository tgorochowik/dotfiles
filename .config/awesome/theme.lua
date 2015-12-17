local theme = dofile('/usr/share/awesome/themes/zenburn/theme.lua')
local icons = os.getenv("HOME") .. "/.config/awesome/icons/"

-- general
theme.font      = "profont 8"
theme.fg_normal = "#DCDCCC"
theme.fg_focus  = "#DCDCCC"
theme.fg_urgent = "#CC9393"
theme.bg_normal = "#3F3F3F"
theme.bg_focus  = "#2A2A2A"
theme.bg_urgent = "#3F3F3F"

-- border
theme.border_width  = "1"
theme.border_normal = "#303030"
theme.border_focus  = "#444444"
theme.border_marked = "#CC9393"

-- icons
theme.mailicon          = icons .. "mail.png"
theme.separator         = icons .. "separator.png"

theme.layout_tile       = icons .. "tile.png"
theme.layout_tilegaps   = icons .. "tilegaps.png"
theme.layout_tileleft   = icons .. "tileleft.png"
theme.layout_tilebottom = icons .. "tilebottom.png"
theme.layout_tiletop    = icons .. "tiletop.png"
theme.layout_fairv      = icons .. "fairv.png"
theme.layout_fairh      = icons .. "fairh.png"
theme.layout_spiral     = icons .. "spiral.png"
theme.layout_dwindle    = icons .. "dwindle.png"
theme.layout_max        = icons .. "max.png"
theme.layout_fullscreen = icons .. "fullscreen.png"
theme.layout_magnifier  = icons .. "magnifier.png"
theme.layout_floating   = icons .. "floating.png"

theme.taglist_squares_unsel = icons .. "squareza.png"
theme.taglist_squares_sel   = icons .. "squarez.png"

theme.widget_ac             = icons .. "ac.png"
theme.widget_battery        = icons .. "battery.png"
theme.widget_battery_low    = icons .. "battery_low.png"
theme.widget_battery_empty  = icons .. "battery_empty.png"
theme.widget_mem            = icons .. "mem.png"
theme.widget_cpu            = icons .. "cpu.png"
theme.widget_temp           = icons .. "temp.png"
theme.widget_net            = icons .. "net.png"
theme.widget_hdd            = icons .. "hdd.png"
theme.widget_music          = icons .. "note.png"
theme.widget_music_on       = icons .. "note_on.png"
theme.widget_vol            = icons .. "vol.png"
theme.widget_vol_low        = icons .. "vol_low.png"
theme.widget_vol_no         = icons .. "vol_no.png"
theme.widget_vol_mute       = icons .. "vol_mute.png"
theme.widget_mail           = icons .. "mail.png"
theme.widget_mail_on        = icons .. "mail_on.png"

theme.awesome_icon           = nil
theme.menu_submenu_icon      = nil
theme.tasklist_floating_icon = nil

return theme
