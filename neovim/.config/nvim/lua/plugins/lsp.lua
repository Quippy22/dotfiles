return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "pyright",
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

            vim.lsp.config("lua_ls", {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                    },
                },
            })

            vim.lsp.config("clangd", {
                on_attach = on_attach,
                capabilities = capabilities,
            })

            vim.lsp.config("pyright", {
                on_attach = on_attach,
                capabilities = capabilities,
            })

            vim.lsp.enable("lua_ls")
            vim.lsp.enable("clangd")
            vim.lsp.enable("pyright")
        end,
    },
}
