local style = {
    shell = "serpantinum",

    apps = {
        terminal = "kitty",
        file_manager = "ski",
        launcher = "serpantinum msg toggle launcher",
        lock = "serpantinum lock",
        clipboard = "serpantinum msg toggle clipboard",
        calendar = "serpantinum msg toggle calendar",
        notifications = "serpantinum msg toggle notifications",
        dashboard = "serpantinum msg toggle system",
        settings = "serpantinum settings",
        gtk_theme = "Arc-Dark",
    },

    persistent_terminal = {
        class = "persist-term",
        workspace = "special:persist",
        size = "3400 450",
        move = "10 970",
    },

    resize = {
        tiled_step = 20,
        float_step = 20,
    },

    wallpaper = {
        path = "/home/darius/Images/wallpapers/night-sky-clouds-BG.jpg",
        fit_mode = "cover",
    },

    config = {
        general = {
            gaps_in  = 1,
            gaps_out = 2,
            border_size = 1,
            col = {
                active_border   = "rgba(ffffffaa)",
                inactive_border = "rgba(333333aa)",
            },
            resize_on_border = true,
            allow_tearing = false,
            layout = "dwindle",
        },

        decoration = {
            rounding       = 0,
            rounding_power = 2,
            active_opacity   = 1.0,
            inactive_opacity = 1.0,
            shadow = {
                enabled      = false,
            },
            blur = {
                enabled   = false,
            },
        },

        animations = {
            enabled = true,
        },

        dwindle = {
            preserve_split = true,
            force_split = 2,
        },

        master = {
            new_status = "master",
        },

        misc = {
            force_default_wallpaper = -1,
            disable_hyprland_logo   = false,
        },

        input = {
            kb_layout  = "us",
            follow_mouse = 1,
            sensitivity = 0,
            touchpad = {
                natural_scroll = false,
            },
        },
    },

    curves = {
        easeOutQuint = { type = "bezier", points = { {0.23, 1}, {0.32, 1} } },
        easeInOutCubic = { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } },
        linear = { type = "bezier", points = { {0, 0}, {1, 1} } },
        almostLinear = { type = "bezier", points = { {0.5, 0.5}, {0.75, 1} } },
        quick = { type = "bezier", points = { {0.15, 0}, {0.1, 1} } },
        easy = { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 },
    },

    animation_rules = {
        { leaf = "global", enabled = true, speed = 10, bezier = "default" },
        { leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" },
        { leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" },
        { leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" },
        { leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" },
        { leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" },
        { leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" },
        { leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" },
        { leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" },
        { leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" },
        { leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" },
        { leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" },
        { leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" },
        { leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "slide" },
        { leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "slide" },
        { leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "slide" },
        { leaf = "specialWorkspace", enabled = true, speed = 6, bezier = "easeOutQuint", style = "slidevert" },
        { leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" },
    },

    gestures = {
        {
            fingers = 3,
            direction = "horizontal",
            action = "workspace",
        },
    },

    devices = {
        {
            name = "epic-mouse-v1",
            sensitivity = -0.5,
        },
    },
}

return style
