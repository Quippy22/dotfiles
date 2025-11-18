return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = function()
			require("mason").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
					"pyright",
					"rust_analyzer",
					"html",
					"tailwindcss",
					"pylsp",
					"prettier",
					"djlint",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
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

			vim.lsp.config("pyright", {
				on_attach = on_attach,
				capabilities = capabilities,
			})

			vim.lsp.config("lua_ls", {
				on_attach = on_attach,
				capabilities = capabilities,
			})

			vim.lsp.config("clangd", {
				on_attach = on_attach,
				capabilities = capabilities,
			})

			vim.lsp.config("rust_analyzer", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						check = { command = "clippy" },
					},
				},
			})

			vim.lsp.config("html", {
				on_attach = on_attach,
				capabilities = capabilities,
			})

			vim.lsp.config("tailwindcss", {
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = {
					"html",
					"eruby",
					"svelte",
					"typescriptreact",
					"javascriptreact",
					"vue",
					"php",
					"htmldjango",
				},
			})

			vim.lsp.config("pylsp", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					pylsp = {
						plugins = {
							pyls_django = {
								enabled = true,
							},
						},
					},
				},
			})

			vim.lsp.config("djlint", {
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,
	},
}
