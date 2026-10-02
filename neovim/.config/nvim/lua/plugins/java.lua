return {
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		config = function()
			local jdtls = require("jdtls")

			local root = vim.fs.root(0, {
				"gradlew",
				"settings.gradle",
				"settings.gradle.kts",
				"build.gradle",
				"build.gradle.kts",
				"pom.xml",
				".git",
			})
			if not root then
				return
			end

			local workspace_dir = vim.fn.stdpath("cache")
				.. "/jdtls/"
				.. vim.fs.basename(vim.fs.dirname(root))
				.. "_"
				.. vim.fs.basename(root)

			jdtls.start_or_attach({
				name = "jdtls",
				cmd = { "jdtls", "-data", workspace_dir },
				root_dir = root,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				init_options = { bundles = {} },
				settings = {
					java = {
						-- AGP modules expose no java sourceSets; this makes jdtls
						-- inject its own android init script (source dirs + android.jar)
						jdt = { ls = { androidSupport = { enabled = true } } },
						configuration = {
							runtimes = {
								{ name = "JavaSE-17", path = "/usr/lib/jvm/java-17-openjdk", default = true },
								{ name = "JavaSE-1.8", path = "/usr/lib/jvm/java-8-openjdk" },
							},
						},
					},
				},
				on_attach = function(_, bufnr)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover" })
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP Definition" })
					vim.keymap.set("n", "<A-o>", jdtls.organize_imports, { buffer = bufnr, desc = "Java: Organize Imports" })
				end,
			})
		end,
	},
	{
		"oclay1st/gradle.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		cmd = { "Gradle", "GradleExec", "GradleInit", "GradleFavorites" },
		keys = {
			{ "<leader>G", desc = "+Gradle", mode = { "n", "v" } },
			{ "<leader>Gg", "<cmd>Gradle<cr>", desc = "Gradle: Projects" },
			{ "<leader>Gf", "<cmd>GradleFavorites<cr>", desc = "Gradle: Favorites" },
		},
		opts = {
			-- resolves against nvim's cwd, so open nvim from the project root
			gradle_executable = "./gradlew",
		},
	},
}
