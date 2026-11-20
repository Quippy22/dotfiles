return {
    shell = "serpantinum",

    apps = {
        launcher = "serpantinum msg toggle launcher",
        file_manager = "ski",
        lock = "serpantinum lock",
        clipboard = "serpantinum msg toggle clipboard",
        calendar = "serpantinum msg toggle calendar",
        notifications = "serpantinum msg toggle notifications",
        dashboard = "serpantinum msg toggle system",
        settings = "serpantinum settings",
        gtk_theme = "Arc-Dark",
    },

    persistent_terminal = {
        size = "3400 450",
        move = "20 950",
    },

    config = {
        general = {
            gaps_in = 1,
            gaps_out = 2,
            border_size = 1,
            col = {
                active_border = "rgba(ffffffaa)",
                inactive_border = "rgba(333333aa)",
            },
            resize_on_border = true,
        },

        decoration = {
            rounding = 0,
            shadow = {
                enabled = false,
            },
            blur = {
                enabled = false,
            },
        },
    },
}
