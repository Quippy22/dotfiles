return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        local ts = require("nvim-treesitter")
        local install = require("nvim-treesitter.install")
        local config = require("nvim-treesitter.config")

        ts.setup({})

        -- Preferred parsers to always have
        local languages = {
            "c", "cpp", "lua", "vim", "vimdoc", "query", "python", 
            "javascript", "html", "markdown", "markdown_inline", "bash", "yaml", "json",
        }
        ts.install(languages)

        -- Helper to auto-install missing parsers
        local function auto_install(lang)
            if not lang then return end
            local installed = config.get_installed()
            if not vim.list_contains(installed, lang) then
                -- Check if it's a valid parser first
                local parsers = require("nvim-treesitter.parsers")
                if parsers[lang] then
                    vim.notify("Treesitter: Auto-installing '" .. lang .. "'...")
                    ts.install(lang)
                end
            end
        end

        -- Enable highlighting, indentation, and auto-install
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local bufnr = args.buf
                local ft = vim.bo[bufnr].filetype
                local lang = vim.treesitter.language.get_lang(ft) or ft
                
                -- Attempt auto-install
                auto_install(lang)

                if lang then
                    pcall(vim.treesitter.start, bufnr, lang)
                    vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })

        -- Incremental selection
        vim.keymap.set("n", "<c-space>", "v", { desc = "Treesitter: Init Selection" })

        -- Configure textobjects
        require("nvim-treesitter-textobjects").setup({
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                },
            },
        })

        -- Keymap to yank the current function under the cursor
        vim.keymap.set("n", "<leader>yf", [[:normal! vaf y<CR>]], { noremap = true, silent = true, desc = "Treesitter: Yank Function" })
    end,
}
