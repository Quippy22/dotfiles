return {
    "ggandor/leap.nvim",
    event = "VeryLazy", -- Load on first use

    config = function()
        require("leap").setup({})

        vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward-to)")
        vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward-to)")
    end,
}
