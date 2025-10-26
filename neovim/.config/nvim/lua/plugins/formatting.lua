return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
        local conform = require("conform")

        conform.setup({
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },

            formatters_by_ft = {
                -- Rust
                rust = { "rustfmt" },

                -- Lua
                lua = { "stylua --indent-width 4 --indent-type Spaces" },

                -- Python
                python = { "isort", "black --line-length 120" },

                -- C/C++
                c = { "clang_format --style={BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Never}" },
                cpp = { "clang_format --style={BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Never}" },
            },
        })

        vim.keymap.set("n", "<leader>gf", function()
            conform.format({ async = true, lsp_fallback = true })
        end, { desc = "Format buffer [conform]" })
    end,
}
