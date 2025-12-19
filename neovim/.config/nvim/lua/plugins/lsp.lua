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
					"pylsp",
				},
			})
			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettier",
					"djlint",
					"stylua",
					"isort",
					"black",
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
			vim.diagnostic.config({ virtual_text = true })
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
				"pylsp",
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
						"htmldjango",
					}
				elseif server_name == "pylsp" then
					server_opts.settings = {
						pylsp = {
							plugins = {
								pyls_django = {
									enabled = true,
								},
							},
						},
					}
				end
				vim.lsp.config(server_name, server_opts)
				vim.lsp.enable(server_name)
			end
		end,
	},
}