return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        require("mason-nvim-dap").setup({
            ensure_installed = { "codelldb" },
            handlers = {},
        })

        require("dapui").setup()

        dap.listeners.before.attach.dapui_config = function() dapui.open() end
        dap.listeners.before.launch.dapui_config = function() dapui.open() end
        dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
        dap.listeners.before.event_exited.dapui_config = function() dapui.close() end


        dap.configurations.rust = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
        }

        vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
        vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP: Continue" })
        vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "DAP: Step Over" })
        vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP: Step Into" })
        vim.keymap.set("n", "<leader>ds", dap.step_out, { desc = "DAP: Step Out" })
        vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })
        vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "DAP: Open REPL" })
    end,
}
