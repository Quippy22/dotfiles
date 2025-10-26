return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "pyright",
                    "rust_analyzer", -- Ensure this is here
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            vim.diagnostic.config({ virtual_text = true })

            local on_attach = function(client, bufnr)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover" })
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP Definition" })
            end

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Your lua_ls, clangd, pyright configs... (keep them)

            -- ADDED: rust-analyzer config
            vim.lsp.config("rust_analyzer", {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        check = { command = "clippy" },
                    },
                },
            })

            -- Your existing enable lines...
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("clangd")
            vim.lsp.enable("pyright")
            -- ADDED: enable rust_analyzer
            vim.lsp.enable("rust_analyzer")
        end,
    },
}
