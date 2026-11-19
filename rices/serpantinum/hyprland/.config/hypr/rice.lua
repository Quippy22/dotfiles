return {
    shell = "serpantinum",

    apps = {
        launcher = "serpantinum msg toggle launcher",
        gtk_theme = "Arc-Dark",
    },

    waybar = {
        order = -999,
    },

    wallpaper = {
        path = "/home/darius/Images/wallpapers/night-sky-clouds-BG.jpg",
        fit_mode = "cover",
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
