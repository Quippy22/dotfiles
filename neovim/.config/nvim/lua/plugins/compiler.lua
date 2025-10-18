return {
    "CRAG666/code_runner.nvim",
    config = function()
        require("code_runner").setup({
            mode = "float",
            float = {
                border = "rounded",
            },
            focus = true,
            startinsert = false,
            filetype = {
                c = {
                    "cd $dir && gcc $fileName -o $fileNameWithoutExt",
                    "&& ./$fileNameWithoutExt",
                    "&& rm $fileNameWithoutExt",
                },
                cpp = {
                    "cd $dir && g++ $fileName -o $fileNameWithoutExt",
                    "&& ./$fileNameWithoutExt",
                    "&& rm $fileNameWithoutExt",
                },
                python = "python3 -u",
                java = {
                    "cd $dir && javac $fileName",
                    "&& java $fileNameWithoutExt",
                },
            },
        })

        -- Keymaps
        vim.keymap.set("n", "<leader>rr", "<cmd>RunCode<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>rf", "<cmd>RunFile<CR>", { noremap = true, silent = true })
    end,
}
