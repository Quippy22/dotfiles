return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		formatters_by_ft = {
			rust = { "rustfmt" },
			lua = { "stylua" },
			python = { "isort", "black" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			html = { "prettier" },
			htmldjango = { "djlint" },
		},
		formatters = {
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
	},
	init = function()
		vim.keymap.set("n", "<leader>gf", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, { desc = "Format buffer [conform]" })
	end,
}
