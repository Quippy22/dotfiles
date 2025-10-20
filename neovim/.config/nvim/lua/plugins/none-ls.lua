return {
    "nvimtools/none-ls.nvim",
    config = function()
        local none_ls = require("null-ls")

        none_ls.setup({
            sources = {
                -- Lua
                none_ls.builtins.formatting.stylua.with({
                    extra_args = {
                        "--indent-width",
                        "4",
                        "--indent-type",
                        "Spaces",
                    },
                }),

                -- Python
                none_ls.builtins.formatting.isort,
                none_ls.builtins.formatting.black.with({
                    extra_args = { "--line-length", "120" },
                }),

                -- C/C++
                none_ls.builtins.formatting.clang_format.with({
                    extra_args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Never}" },
                }),
            },
        })

        vim.keymap.set("n", "<leader>gf", function()
            vim.lsp.buf.format({ name = "null-ls" })
        end, {})
    end,
}
