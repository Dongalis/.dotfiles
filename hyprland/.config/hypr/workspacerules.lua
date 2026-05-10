------------------
--- WORKSPACES ---
------------------

-- See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rulesi

hl.workspace_rule({
    workspace = "special:music",
    gaps_out = 100,
    on_created_empty = music,
})

hl.workspace_rule({
    workspace = "special:pass",
    gaps_out = 100,
    on_created_empty = pass,
})

hl.workspace_rule({
    workspace = "special:notes",
    gaps_out = 100,
    on_created_empty = notes,
})

