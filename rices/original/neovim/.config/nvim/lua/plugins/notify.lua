return {
    "rcarriga/nvim-notify",
    config = function()
        vim.notify = require("notify")
        require("notify").setup({
            stages = "fade_in_slide_out",
            timeout = 2000,
            render = "default",

            background_colour = "NONE", -- makes it transparent
            border = "rounded", -- rounded edges
        })

        --  white border highlight
        vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NotifyBorder", { fg = "#ffffff" })
    end,
}
