--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

local style = require("style")

hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    name  = "persist-term",
    match = { class = style.persistent_terminal.class },
    float = true,
    size  = style.persistent_terminal.size,
    move  = style.persistent_terminal.move,
    workspace = style.persistent_terminal.workspace,
})

hl.window_rule({
    name = "discord-workspace",
    match = { class = "^(discord|Discord)$" },
    workspace = "3 silent",
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})
