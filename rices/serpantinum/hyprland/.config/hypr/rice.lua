return {
    shell = "serpantinum",

    apps = {
        launcher = "serpantinum msg toggle launcher",
        file_manager = "ski",
        lock = "serpantinum lock",
        clipboard = "serpantinum msg toggle clipboard",
        calendar = "serpantinum msg toggle calendar",
        dashboard = "serpantinum msg toggle system",
        settings = "serpantinum settings",
        gtk_theme = "Arc-Dark",
    },

    persistent_terminal = {
        size = "3400 450",
        move = "10 970",
    },

    config = {
        general = {
            gaps_in = 4,
            gaps_out = 6,
            border_size = 2,
            resize_on_border = true,
        },

        decoration = {
            rounding = 12,
            blur = {
                enabled = true,
                size = 8,
                passes = 2,
            },
            shadow = {
                enabled = false,
            },
        },
    },
}
