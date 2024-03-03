return {
  'eandrju/cellular-automaton.nvim',
  config = function()
    vim.keymap.set(
      "n",
      "<leader>mr",
      "<cmd>CellularAutomaton make_it_rain<CR>",
      { desc = 'CellularAutomaton Make It Rain' }
    );
    vim.keymap.set(
      "n",
      "<leader>ml",
      "<cmd>CellularAutomaton game_of_life<CR>",
      { desc = 'CellularAutomaton Game Of Life' }
    )
  end
}
