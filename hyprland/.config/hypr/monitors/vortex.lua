----------------
--- MONITORS ---
----------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
    output   = "DP-1",
    mode     = "preferred",
    position = "1080x260",
    scale    = "auto",
})

hl.monitor({
    output    = "DP-2",
    mode      = "preferred",
    position  = "0x0",
    scale     = "auto",
    transform = 1,
})
