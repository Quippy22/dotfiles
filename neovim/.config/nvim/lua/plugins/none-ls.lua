return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                -- Lua
                null_ls.builtins.formatting.stylua.with({
                    extra_args = {
                        "--indent-width",
                        "4",
                        "--indent-type",
                        "Spaces",
                    },
                }),

                -- Python
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.black.with({
                    extra_args = { "--line-length", "120" },
                }),

                -- C/C++
                null_ls.builtins.formatting.clang_format.with({
                    extra_args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Never}" },
                }),
            },
        })
        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
}
