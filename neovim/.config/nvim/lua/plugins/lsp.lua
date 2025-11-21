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

			-- This is the new, correct syntax for Neovim 0.11+
			local servers = {
				"pyright",
				"lua_ls",
				"clangd",
				"rust_analyzer",
				"html",
				"tailwindcss",
				"pylsp",
				"djlint",
			}

			for _, server_name in ipairs(servers) do
				local server_opts = {
					on_attach = on_attach,
					capabilities = capabilities,
				}

				-- Add server-specific settings here
				if server_name == "tailwindcss" then
					server_opts.filetypes =
						{ "html", "eruby", "svelte", "typescriptreact", "javascriptreact", "vue", "php", "htmldjango" }
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
			end
		end,
	},
}

