return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "rust", "lua", "python", "c", "cpp" },
    cmd = { "ConformInfo" },
    config = function()
        print("--- Loading conform.nvim configuration (NO format on save) ---")

        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                rust = { "rustfmt" },
                lua = { "stylua --indent-width 4 --indent-type Spaces" },
                python = { "isort", "black --line-length 120" },
                c = { "clang_format --style={BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Never}" },
                cpp = { "clang_format --style={BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Never}" },
            },
        })

        vim.keymap.set("n", "<leader>gf", function()
            conform.format({ async = true, lsp_fallback = true })
        end, { desc = "Format buffer [conform]" })
    end,
}
