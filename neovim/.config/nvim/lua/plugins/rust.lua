return {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
        -- Keymaps only for Rust buffers
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "rust",
            callback = function()
                local bufnr = vim.api.nvim_get_current_buf()
                -- Use <leader>c for Cargo-related actions
                vim.keymap.set(
                    "n",
                    "<leader>cr",
                    "<cmd>RustLsp runnables<CR>",
                    { silent = true, buffer = bufnr, desc = "Cargo Run" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>ct",
                    "<cmd>RustLsp testables<CR>",
                    { silent = true, buffer = bufnr, desc = "Cargo Test" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>cd",
                    "<cmd>RustLsp debuggables<CR>",
                    { silent = true, buffer = bufnr, desc = "Cargo Debug" }
                )

                -- Other Rust-specific actions (can keep these)
                vim.keymap.set(
                    "n",
                    "<leader>rm",
                    "<cmd>RustLsp expandMacro<CR>",
                    { silent = true, buffer = bufnr, desc = "Rust: Expand Macro" }
                )
                vim.keymap.set(
                    "n",
                    "K",
                    "<cmd>RustLsp hover actions<CR>",
                    { silent = true, buffer = bufnr, desc = "Rust: Hover Actions" }
                )
            end,
        })
    end,
}
