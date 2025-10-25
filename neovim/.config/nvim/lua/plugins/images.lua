return {
    {
        "vhyrro/luarocks.nvim",
        priority = 1001,
        opts = {
            rocks = { "magick" },
        },
    },

    {
        "3rd/image.nvim",
        dependencies = { "vhyrro/luarocks.nvim" },
        opts = {
            backend = "kitty",
            processor = "magick_rock",
            filetypes = { "jpeg", "jpg", "png", "webp", "gif" },
        },
    },
}
