return {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- remove spaces
            surrounds = {
                ["("] = {
                    add = { "(", ")" },
                },
                ["{"] = {
                    add = { "{", "}" },
                },
                ["["] = {
                    add = { "[", "]" },
                },
            },
        })
    end,
}
