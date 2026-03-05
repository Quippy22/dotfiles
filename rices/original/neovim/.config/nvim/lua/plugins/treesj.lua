return {
    "Wansmer/treesj",
    keys = {
        { "<leader>m", "<cmd>TSJToggle<cr>", desc = "TreeSJ: Toggle Split/Join" },
        { "<leader>j", "<cmd>TSJJoin<cr>", desc = "TreeSJ: Join" },
        { "<leader>s", "<cmd>TSJSplit<cr>", desc = "TreeSJ: Split" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("treesj").setup({
            use_default_keymaps = false,
        })
    end,
}
