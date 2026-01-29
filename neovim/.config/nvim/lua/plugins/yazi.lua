return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>n",
            function()
                require("yazi").yazi()
            end,
            desc = "Open Yazi",
        },
    },
    opts = {
        open_for_directories = false,
        keymaps = {
            show_help = '<f1>',
        },
    },
}
