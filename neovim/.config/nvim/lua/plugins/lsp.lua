return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
					"pyright",
					"rust_analyzer",
					"html",
					"tailwindcss",
					"ruff",
				},
			})
			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettier",
					"stylua",
					"clang-format",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			vim.diagnostic.config({
				virtual_text = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = "󰠠 ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
				underline = true,
				update_in_insert = true,
				severity_sort = true,
			})

			local on_attach = function(client, bufnr)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover" })
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP Definition" })
			end
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local servers = {
				"pyright",
				"lua_ls",
				"clangd",
				"rust_analyzer",
				"html",
				"tailwindcss",
				"ruff",
			}
			for _, server_name in ipairs(servers) do
				local server_opts = {
					on_attach = on_attach,
					capabilities = capabilities,
				}
				if server_name == "tailwindcss" then
					server_opts.filetypes = {
						"html",
						"eruby",
						"svelte",
						"typescriptreact",
						"javascriptreact",
						"vue",
						"php",
					}
				end
				vim.lsp.config(server_name, server_opts)
				vim.lsp.enable(server_name)
			end
		end,
	},
}
