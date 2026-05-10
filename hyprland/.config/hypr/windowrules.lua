------------------------------
--- WINDOWS AND WORKSPACES ---
------------------------------

-- See https://wiki.hypr.land/Configuring/Window-Rules/ for more

-- Example windowrules that are useful

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name = suppress-maximize-events
    
    match = {
        class = .*
    }
    suppress_event = maximize
})

-- Oppacity config
hl.window_rule({ match = {class = ".*"} opacity = "0.8 0.6 1"})
hl.window_rule({ match = {class = "^org.kde.pix$"} opacity = "1 0.8 1"})
hl.window_rule({ match = {class = "^com.github.rafostar.Clapper$"} opacity = "1 0.8 1"})
hl.window_rule({ match = {class = "^firefox$"} opacity = "1 0.8 1"})
hl.window_rule({ match = {class = "^MuseScore4$"} opacity = "1 0.8 1"})
hl.window_rule({ match = {class = "^firefox$", title = "^Picture-in-Picture$"} opacity = "1 1 1"})
hl.window_rule({ match = {class = "^steam$"} opacity = "1 0.6 1"})
hl.window_rule({ match = {class = "^steam$", title = "^$"} opacity = "1 0.8 1"})

hl.window_rule({ match = {workspace = "10"} opacity = "1 1 1"})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name = fix-xwayland-drags
    
    match = {
        class = ^$
        title = ^$
        xwayland = true
        float = true
        fullscreen = false
        pin = false
    }

    no_focus = true
})

-- Hyprland-run windowrule
hl.window_rule({
    name = move-hyprland-run

    match = {
        class = hyprland-run
    }
    move = 20 monitor_h-120
    float = yes
})

hl.window_rule({
    name = proton-pass

    match = {
        class = ^(Proton Pass)$
    }
    float = yes
    center = yes
})

hl.window_rule({
    name = Spotify

    match = {
        class = ^spotify$   
    }
    workspace = special:music
    suppress_event = [fullscreen, maximize, fullscreenoutput]
    float = false
    fullscreen_state = 0
    pseudo = false
    tile = true
})

hl.window_rule({
    name = Proton Pass

    match = {
        class = ^Proton Pass$   
    }
    workspace = special:pass
    suppress_event = [fullscreen, maximize, fullscreenoutput]
    float = false
    fullscreen_state = 0
    pseudo = false
    tile = true
})

hl.window_rule({
    name = Obsidian

    match = {
        class = ^obsidian$
    }

    workspace = special:notes
    suppress_event = [fullscreen, maximize, fullscreenoutput]
    float = false
    fullscreen_state = 0
    pseudo = false
    tile = true
})

hl.window_rule({
    name = Steam Firend list

    match = {
        class = ^steam$   
        title = ^Friends List$
    }
    float = true
})

hl.window_rule({
    name = Thunar rename
    match = {
        class = ^Thunar$   
        title = ^Rename ".*"$
    }
    float = true
})

hl.window_rule({
    name = firefox Picture in picture
    
    match = {
        class = ^firefox$
	    title = ^Picture-in-Picture$
    }
    
    float = true
})

hl.window_rule({
    name = Satty (screanshot anotation)
    match = {
        class = ^com.gabm.satty$
    }
    float = true
    center = true
    max_size = (monitor_w*0.8) (monitor_h*0.8)

})
