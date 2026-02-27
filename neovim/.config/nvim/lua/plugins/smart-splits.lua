return {
    "mrjones2014/smart-splits.nvim",
    config = function()
        require("smart-splits").setup({
            -- Multiplexer support
            multiplexer_integration = "zellij",
            -- Only enable resizing
            ignored_filetypes = {},
            default_amount = 3,
            resize_mode = {
                hooks = {
                    on_enter = nil,
                    on_leave = nil,
                },
            },
        })

        -- Keymaps 
        local ss = require("smart-splits")
        vim.keymap.set("n", "<C-h>", ss.move_cursor_left)
        vim.keymap.set("n", "<C-j>", ss.move_cursor_down)
        vim.keymap.set("n", "<C-k>", ss.move_cursor_up)
        vim.keymap.set("n", "<C-l>", ss.move_cursor_right)

        vim.keymap.set("n", "<C-Up>", ss.resize_up, { desc = "Resize up" })
        vim.keymap.set("n", "<C-Down>", ss.resize_down, { desc = "Resize down" })
        vim.keymap.set("n", "<C-Left>", ss.resize_left, { desc = "Resize left" })
        vim.keymap.set("n", "<C-Right>", ss.resize_right, { desc = "Resize right" })
    end,
}
