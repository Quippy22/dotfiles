local function deep_merge(base, override)
    for key, value in pairs(override) do
        if type(base[key]) == "table" and type(value) == "table" then
            deep_merge(base[key], value)
        else
            base[key] = value
        end
    end
end

local style = {
    apps = {
        terminal = "kitty",
        file_manager = "nautilus",
        launcher = "wofi --show drun --layer=overlay",
        gtk_theme = "Arc-Dark",
    },

    waybar = {
        order = -1,
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
            gaps_in  = 2,
            gaps_out = 4,
            border_size = 2,
            col = {
                active_border   = { colors = {"rgba(f03030ee)", "rgba(f7439add)"}, angle = 45 },
                inactive_border = { colors = {"rgba(f0303088)", "rgba(f7439a77)"}, angle = 45 },
            },
            resize_on_border = false,
            allow_tearing = false,
            layout = "dwindle",
        },

        decoration = {
            rounding       = 10,
            rounding_power = 2,
            active_opacity   = 1.0,
            inactive_opacity = 1.0,
            shadow = {
                enabled      = true,
                range        = 4,
                render_power = 3,
                color        = "rgba(1a1a1aee)",
            },
            blur = {
                enabled   = true,
                size      = 1,
                passes    = 1,
                vibrancy  = 0.1696,
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

local ok, rice = pcall(require, "rice")
if ok and type(rice) == "table" then
    deep_merge(style, rice)
end

return style
