return {
  {
    'smoka7/hop.nvim',
    version = '*',
    config = function()
      require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
      vim.keymap.set('n', '<leader>kk', ':HopWord<CR>', { noremap = true, silent = true })
    end,
  },
}
