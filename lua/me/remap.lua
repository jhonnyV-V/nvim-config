vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", ":Oil<CR>", { desc = 'File Explorer' })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = 'Save File' })
vim.keymap.set("n", "<leader><leader>", ":so<CR>", { desc = 'Source lua file' })


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move Selected Down' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move Selected Up' })


vim.keymap.set("n", "J", "mzJ`z", { desc = 'Stack next line on current' })


vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Jump half page down' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Jump half page up' })

vim.keymap.set("n", "n", "nzzzv", { desc = 'Next search result' })
vim.keymap.set("n", "N", "Nzzzv", { desc = 'Previous search result' })

vim.keymap.set(
  "n",
  "<leader>vwm",
  function()
    require("vim-with-me").StartVimWithMe()
  end,
  { desc = '[V]im [W]ith [M]e' }
)
vim.keymap.set(
  "n",
  "<leader>svwm",
  function()
    require("vim-with-me").StopVimWithMe()
  end,
  { desc = '[S]top [V]im [W]ith [M]e' }
)


vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'Paste without yanking' })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = 'Yank to the + register' })

vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = 'Yank line to the + register' })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = 'Delete to the void' })
vim.keymap.set("n", "<leader>D", [["_D]], { desc = 'Delete line to the void (_ register)' })


vim.keymap.set(
  "n",
  "<leader>tm",
  "<cmd>silent !tmux neww tmux-sessionizer<CR>",
  { desc = 'Open Tmux-sessionizer' }
)

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = 'Lsp Format' })

-- Quick fix navigation
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = 'Next QuickFix Item' })
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = 'Previous QuickFix Item' })
--not sure what it does yet
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

vim.keymap.set(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'Replace word in file' }
)

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

--make file executable?
vim.keymap.set(
  "n",
  "<leader>x",
  "<cmd>!chmod +x %<CR>",
  {
    silent = true,
    desc = 'Make current file an executable (chmod)'
  }
)

vim.keymap.set("n", "<leader>m", "<CMD>MarkdownPreview<CR>", { desc = 'MarkdownPreview Start' })
vim.keymap.set("n", "<leader>mn", "<CMD>MarkdownPreviewStop<CR>", { desc = 'MarkdownPreview Stop' })
vim.keymap.set("n", "<leader>bj", "<CMD>BlackJackNewGame<CR>", { desc = 'BlackJackNewGame' })
