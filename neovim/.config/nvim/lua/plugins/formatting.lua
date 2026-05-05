return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				rust = { "leptosfmt", "rustfmt" },
				lua = { "stylua" },
				python = { "ruff_organize_imports", "ruff_format" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				html = { "prettier" },
			},
			formatters = {
				leptosfmt = {
					command = "leptosfmt",
					args = { "--stdin" },
					stdin = true,
				},
				prettier = {
					prepend_args = { "--tab-width", "4" },
				},
				stylua = {
					prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
				},
				["clang-format"] = {
					prepend_args = { "--style={IndentWidth: 4}" },
				},
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>gf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range" })
	end,
}
