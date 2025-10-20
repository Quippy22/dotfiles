return {
    "akinsho/toggleterm.nvim",
    version = "*",

    opts = {
        direction = "horizontal",
        size = 15, -- 15 lines height

        start_in_insert = true,
        persist_shell = true,
    },

    keys = {
        {
            "<leader>;",
            "<cmd>ToggleTerm<CR>",
            mode = "n",
            desc = "Toggle Terminal (Horizontal)",
            silent = true,
        },
        {
            "<esc>",
            [[<C-\><C-n>]],
            mode = "t",
            desc = "Exit Terminal Mode",
            silent = true,
        },
    },

    config = function(_, opts)
        require("toggleterm").setup(opts)
    end,
}
