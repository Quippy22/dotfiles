return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- Matches your Red-Blue Fusion theme
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#f03030" },
      warning = { "DiagnosticWarn", "WarningMsg", "#e0af68" },
      info = { "DiagnosticInfo", "#7aa2f7" },
      hint = { "DiagnosticHint", "#73daca" },
      default = { "Identifier", "#bb9af7" },
      test = { "Identifier", "#ff9e64" }
    },
  },
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search Todo" },
    { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
  }
}
