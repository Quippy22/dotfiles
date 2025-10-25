return {
    -- We can keep the plugin name, but we will override its config completely.
    "aspeddro/gitui.nvim",
    config = function()
        -- This function creates a floating terminal and cleans it up properly.
        local function open_gitui_float()
            local buf = vim.api.nvim_create_buf(false, true)
            local width = math.floor(vim.o.columns * 0.9)
            local height = math.floor(vim.o.lines * 0.9)
            local col = math.floor((vim.o.columns - width) / 2)
            local row = math.floor((vim.o.lines - height) / 2)

            local win = vim.api.nvim_open_win(buf, true, {
                relative = "editor",
                width = width,
                height = height,
                col = col,
                row = row,
                style = "minimal",
                border = "rounded",
            })

            -- Run 'gitui' in the terminal.
            -- The 'on_exit' callback is the most important part.
            vim.fn.termopen("gitui", {
                on_exit = function(_, _, _)
                    -- When gitui exits (user presses 'q'), close the window.
                    if vim.api.nvim_win_is_valid(win) then
                        vim.api.nvim_win_close(win, true)
                    end
                    -- Schedule the buffer to be deleted.
                    -- We use vim.defer_fn to make sure Neovim has time
                    -- to process the exit before we delete the buffer.
                    vim.defer_fn(function()
                        if vim.api.nvim_buf_is_valid(buf) then
                            vim.api.nvim_buf_delete(buf, { force = true })
                        end
                    end, 50) -- 50ms delay
                end,
            })

            -- Enter terminal mode immediately
            vim.cmd("startinsert")
        end

        vim.api.nvim_create_user_command("Gitui", open_gitui_float, {})

        -- Map your key to the new command
        vim.keymap.set("n", "<leader>gg", "<cmd>Gitui<CR>", { desc = "Open GitUI" })
    end,
}
