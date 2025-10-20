return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPre",

    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c",
                "cpp",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "python",
                "javascript",
                "html",
            },

            sync_install = false,
            auto_install = true,

            highlight = {
                enable = true,
            },

            -- Add textobjects
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
            },
        })

        -- Keymap to yank the current function under the cursor
        vim.api.nvim_set_keymap("n", "<leader>yf", [[:normal! vaf y<CR>]], { noremap = true, silent = true })
    end,
}
