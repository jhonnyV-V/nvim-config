return {
  'mbbill/undotree',
  config = function ()
    vim.keymap.set('n', '<leader>i', vim.cmd.UndotreeToggle, { desc = 'Open UndoTree' })
  end
}
