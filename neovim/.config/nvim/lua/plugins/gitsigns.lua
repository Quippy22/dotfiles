return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        -- Toggle the lines at the numbers
        vim.keymap.set("n", "<leader>gs", gs.toggle_signs, { 
            buffer = bufnr, 
            desc = "Toggle Git signs" 
        })
      end,
    })
  end,
}
