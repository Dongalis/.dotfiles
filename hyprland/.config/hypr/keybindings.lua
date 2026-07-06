-------------------
--- KEYBINDINGS ---
-------------------

-- See https://wiki.hypr.land/Configuring/Keywords/
mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more

hl.bind(mainMod .. " + Delete", hl.dsp.exec_cmd(menu .. " --provider menus:power-menu"))
hl.bind("XF86PowerOff", hl.dsp.exec_cmd(menu .. " --provider menus:power-menu"), {locked = true})

hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
local closeWindowBind = hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) --dwindle
hl.bind(mainMod .. " + S", hl.dsp.layout("togglesplit")) --dwindle
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.layout("swapsplit")) --dwindle

hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(menu .. " --provider clipboard"))
hl.bind(mainMod .. " + SLASH", hl.dsp.exec_cmd(menu .. " --provider menus:keybindings"))

-- Applications
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(browser .. " --private-window"))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal)) -- remove?
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal)) -- remove?
hl.bind(mainMod .. " + ALT + T", hl.dsp.exec_cmd(editor))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(editor)) -- remove?
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(markdown_editor)) -- remove?
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

-- Application dedicated workspaces
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("~/.config/hypr/bin/disaptch-special-workplace.sh 'Proton Pass' pass"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("~/.config/hypr/bin/disaptch-special-workplace.sh spotify music"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("~/.config/hypr/bin/disaptch-special-workplace.sh obsidian notes"))
-- hl.bind(mainMod .. " + Alt + T", hl.dsp.exec_cmd("hyde-shell pypr toggle console"))
-- hl.bind(mainMod .. " ALT + U", hl.dsp.workspace.toggle_special("minimized"))

-- Copy / Paste 
-- hl.bind(mainMod .. " + C", hl.dsp.send_shortcut({mods = "CTRL", key = "Insert"}))
-- hl.bind(mainMod .. " + V", hl.dsp.send_shortcut({mods = "SHIFT", key = "Insert"}))
-- hl.bind(mainMod .. " + X", hl.dsp.send_shortcut({mods = "CTRL", key = "X"}))

-- Screanshots
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region -o " .. screenshot_folder))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m window -m active -o " .. screenshot_folder))
hl.bind("ALT + PRINT", hl.dsp.exec_cmd("hyprshot -m output -m active -o " .. screenshot_folder))
-- hl.bind("CTRL + PRINT", hl.dsp.exec_cmd("hyprshot -m region --raw | satty --filename - "))
-- hl.bind("CTRL + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m window -m active --raw | satty --filename - "))
-- hl.bind("CTRL + ALT + PRINT", hl.dsp.exec_cmd("hyprshot -m output -m active --raw | satty --filename - "))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("pkill hyprpicker || hyprpicker -a"))
-- hl.bind(mainMod .. " + Control + P", hl.dsp.exec_cmd("hyde-shell screenshot sf -- partial screenshot capture (frozen screen)"))

-- Notifications
hl.bind(mainMod .. " + COMMA", hl.dsp.exec_cmd("makoctl dismiss"))
hl.bind(mainMod .. " + SHIFT + COMMA", hl.dsp.exec_cmd("makoctl dismiss --all"))
hl.bind(mainMod .. " + CTRL + COMMA", hl.dsp.exec_cmd("makoctl mode -t do-not-disturb && makoctl mode | grep -q 'do-not-disturb' && notify-send 'Silenced notifications' || notify-send 'Enabled notifications'"))
hl.bind(mainMod .. " + ALT + COMMA", hl.dsp.exec_cmd("makoctl invoke"))
hl.bind(mainMod .. " + SHIFT + ALT + COMMA", hl.dsp.exec_cmd("makoctl restore"))

-- Full screen
hl.bind(mainMod .. " + F11", hl.dsp.window.fullscreen({mode = "fullscreen" , action = "toggle"}))
hl.bind(mainMod .. " + SHIFT + F11", hl.dsp.window.fullscreen({mode = "maximized" , action = "toggle"}))

-- enable / disable arrow navigation
local enableArrowNavigation = true

-- resize step in pixels
local resizeStep = 100

-- direction definitions
local directions = {
    l = {
        key = "H",
        arrow = "left",
        resize = { -resizeStep, 0 },
    },
    r = {
        key = "L",
        arrow = "right",
        resize = { resizeStep, 0 },
    },
    u = {
        key = "K",
        arrow = "up",
        resize = { 0, -resizeStep },
    },
    d = {
        key = "J",
        arrow = "down",
        resize = { 0, resizeStep },
    },
}

for dir, cfg in pairs(directions) do
    local bindKeys = { cfg.key }

    -- optionally include arrow key
    if enableArrowNavigation then
        table.insert(bindKeys, cfg.arrow)
    end

    for _, key in ipairs(bindKeys) do
        -- focus
        hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = dir }))
        -- move window
        hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = dir }))
        -- group move
        hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.window.move({ into_or_create_group = dir }))
        -- resize window
        hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.resize({x = cfg.resize[1],y = cfg.resize[2], relative = true,}))
    end
end

-- Toggle groups
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + ALT + G", hl.dsp.window.move({ out_of_group = true }))

-- Navigate a single set of grouped windows
hl.bind(mainMod .. " + ALT + TAB", hl.dsp.group.next())
hl.bind(mainMod .. " + ALT + SHIFT + TAB", hl.dsp.group.prev())

hl.bind(mainMod .. " + ALT + mouse_down", hl.dsp.group.next())
hl.bind(mainMod .. " + ALT + mouse_up",   hl.dsp.group.prev())

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    -- Switch workspaces with mainMod + [0-9]
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    -- Move active window to a workspace with mainMod + SHIFT + [0-9]
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
    -- Move active window silently to a workspace with $mainMod + SHIFT + ALT + [1-9; 0]
    hl.bind(mainMod .. " + SHIFT + ALT + " .. key,     hl.dsp.window.move({ workspace = i, follow = false }))
    -- Switch to workspace on current monitor
    hl.bind(mainMod .. " + CTRL + " .. key,     hl.dsp.focus({ workspace = i , on_current_monitor = true}))
    -- Activate window in a group by number
    hl.bind(mainMod .. " + ALT + " .. key,     hl.dsp.group.active({ index = i }))
end

-- Scratchpad special workspace
hl.bind(mainMod .. " + Z",         hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "special:scratchpad" }))
hl.bind(mainMod .. " + SHIFT + ALT + Z", hl.dsp.window.move({ workspace = "special:scratchpad",  follow = false }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- TAB between workspaces
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))
-- bindd	= $mainMod CTRL, TAB, Former workspace, workspace, previous

-- Cycle through applications on active workspace
hl.bind("ALT + TAB",  hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + TAB",  hl.dsp.window.cycle_next({ next = false }))

-- Multimedia keys for volume control
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),       { locked = true, repeating = true})
hl.bind("ALT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"), { locked = true, repeating = true})
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),            { locked = true, repeating = true})
hl.bind("ALT + XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"),      { locked = true, repeating = true})
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),           { locked = true, repeating = true})
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),         { locked = true, repeating = true})

-- Multimedia keys for track control
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Laptop LCD brightness control
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true})
hl.bind("ALT + XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 1%+"), { locked = true, repeating = true})
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true})
hl.bind("ALT + XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 1%-"), { locked = true, repeating = true})

-- Control panels
hl.bind(mainMod .. " + CTRL + A", hl.dsp.exec_cmd("[float; center; size 900 600] alacritty -e wiremix"))
hl.bind(mainMod .. " + CTRL + B", hl.dsp.exec_cmd("walker --provider bluetooth"))
hl.bind(mainMod .. " + CTRL + T", hl.dsp.exec_cmd("[float; center; size 900 600] alacritty -e htop"))
-- hl.bind(mainMod .. " + CTRL + W", hl.dsp.exec_cmd("omarchy-launch-wifi"))

--------------
---  Misc  ---
--------------
hl.bind("XF86Calculator", hl.dsp.exec_cmd(menu .. " --provider calc"))
hl.bind(mainMod .. " + ALT + G", hl.dsp.exec_cmd("~/.config/hypr/bin/gamemode.sh obsidian notes"))
-- hl.bind(mainMod .. " + XF86AudioMute", hl.dsp.exec_cmd("switchouutputdevice"))
-- hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("omarchy-hyprland-window-pop"))
-- binddl = $mainMod, K, toggle keyboard layout , exec, hyde-shell keyboardswitch -- switch keyboard layout
-- bindd = $mainMod Control, Down, navigate to the nearest empty workspace , workspace, empty

-- Move focused window to a relative workspace
-- bindd = $mainMod Control+Alt, Right, move window to next relative workspace , movetoworkspace, r+1
-- bindd = $mainMod Control+Alt, Left, move window to previous relative workspace , movetoworkspace, r-1

-- Dictation
-- hl.bind(mainMod .. " + CTRL + X", hl.dsp.exec_cmd("voxtype record start"))
-- hl.bind(mainMod .. " + CTRL + X", hl.dsp.exec_cmd("voxtype record stop"), { release = true})

-- Waybar-less information
-- hl.bind(mainMod .. " + CTRL + ALT + T, hl.dsp.exec_cmd("notify-send '    $(date +'%A %H:%M  —  %d %B W%V %Y')'"))
-- hl.bind(mainMod .. " + CTRL + ALT + B, hl.dsp.exec_cmd("notify-send '󰁹    Battery is at $(omarchy-battery-remaining)%'"))

-- File sharing
-- hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd("omarchy-menu share"))

-- Toggle idling
-- hl.bind(mainMod .. " + CTRL + I", hl.dsp.exec_cmd("omarchy-toggle-idle"))

-- Toggle nightlight
-- hl.bind(mainMod .. " + CTRL + N", hl.dsp.exec_cmd("omarchy-toggle-nightlight"))

-- Aesthetics
-- hl.bind(mainMod .. " + BACKSPACE", hl.dsp.exec_cmd("hyprctl dispatch setprop "address:$(hyprctl activewindow -j | jq -r '.address')" opaque toggle"))
-- hl.bind(mainMod .. " + SHIFT + BACKSPACE", hl.dsp.exec_cmd("omarchy-hyprland-workspace-toggle-gaps"))
-- hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("omarchy-hyprland-window-close-all"))

-- Aplication launcher specific menus
-- hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("pkill -x rofi || $rofi-launch d"))
-- hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd("pkill -x rofi || $rofi-launch w"))
-- hl.bind(mainMod .. " + Shift + E", hl.dsp.exec_cmd("pkill -x rofi || $rofi-launch f"))
-- hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("pkill -x rofi || hyde-shell glyph-picker -- launch glyph picker"))
-- hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("pkill -x rofi || hyde-shell cliphist -c -- launch clipboard,"))
-- hl.bind(mainMod .. " + Shift + V", hl.dsp.exec_cmd("pkill -x rofi || hyde-shell cliphist -- launch clipboard Manager"))
-- hl.bind(mainMod .. " + Shift + A", hl.dsp.exec_cmd("pkill -x rofi || hyde-shell rofiselect -- launch select menu"))

