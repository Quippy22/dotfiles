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
		},
	},
	init = function()
		vim.keymap.set("n", "<leader>gf", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, { desc = "Format buffer [conform]" })
	end,
}
