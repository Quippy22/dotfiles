return {
  "mbbill/undotree",
  keys = {
    { "<leader>t", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
  },
  config = function()
    -- Optional settings
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
}

