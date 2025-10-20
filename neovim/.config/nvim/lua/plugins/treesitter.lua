return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'BufReadPre',

  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'c',
        'cpp',
        'lua',
        'vim',
        'vimdoc',
        'query',
        'python',
        'javascript',
        'html',
      },

      -- Install parsers synchronously (only for parsers in ensure_installed)
      sync_install = false,

      -- Automatically install missing parsers (only for parsers in ensure_installed)
      auto_install = true,

      highlight = {
        enable = true,
      },
    })
  end,
}
