return {
  'sudormrfbin/cheatsheet.nvim',
  dependencies = {
    {'nvim-telescope/telescope.nvim'},
    {'nvim-lua/popup.nvim'},
    {'nvim-lua/plenary.nvim'},
  },
  config = function()
    require('cheatsheet').setup({
      bundled_cheatsheets = {
        enabled = {}, -- Still disable bloat
      },
      bundled_plugin_cheatsheets = {
        enabled = {}, -- Still disable bloat
      },
    })
    
    -- Main keybind
    vim.keymap.set("n", "<leader>?", "<cmd>Cheatsheet<cr>", { desc = "Search Hard Binds" })
  end
}
