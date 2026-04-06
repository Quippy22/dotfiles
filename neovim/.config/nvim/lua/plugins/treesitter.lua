pcall(function() require('nvim-treesitter.install').prefer_git = true end)
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = "BufReadPre",

    config = function()
        require('nvim-treesitter.install').prefer_git = true
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
        vim.keymap.set("n", "<leader>yf", [[:normal! vaf y<CR>]], { noremap = true, silent = true, desc = "Treesitter: Yank Function" })
    end,
}
