return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-project.nvim",
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({})

            telescope.load_extension("project")

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<C-p>", function()
                builtin.find_files({})
            end, { desc = "Find files" })
            vim.keymap.set("n", "<leader>fg", function()
                builtin.live_grep({})
            end, { desc = "Live grep" })
            vim.keymap.set("n", "<leader>?", function()
                builtin.keymaps({})
            end, { desc = "Search Keymaps" })
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
