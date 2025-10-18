return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight")

            vim.defer_fn(function()
                local hl = vim.api.nvim_set_hl

                -- editor transparency
                hl(0, "Normal", { bg = "none" })
                hl(0, "NormalNC", { bg = "none" })
                hl(0, "SignColumn", { bg = "none" })
                hl(0, "VertSplit", { bg = "none" })

                -- neotree transparency
                hl(0, "NeoTreeNormal", { bg = "none" })
                hl(0, "NeoTreeNormalNC", { bg = "none" })
                hl(0, "NeoTreeEndOfBuffer", { bg = "none" })
                hl(0, "NeoTreeWinSeparator", { bg = "none" })

                -- telescope transparency
                hl(0, "TelescopeNormal", { bg = "none" })
                hl(0, "TelescopeBorder", { bg = "none" })
                hl(0, "TelescopePromptNormal", { bg = "none" })
                hl(0, "TelescopePromptBorder", { bg = "none" })
                hl(0, "TelescopeResultsNormal", { bg = "none" })
                hl(0, "TelescopeResultsBorder", { bg = "none" })
                hl(0, "TelescopePreviewNormal", { bg = "none" })
                hl(0, "TelescopePreviewBorder", { bg = "none" })
            end, 50)
        end,
    },
}
