vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", ":Ex<CR>")
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader><leader>", ":so<CR>")

--move code selected up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--stack next line of code in your actual line
vim.keymap.set("n", "J", "mzJ`z")

--jump to the middle of the file
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- shoudl help while searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
  require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
  require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
-- true
-- paste over selected text whitout copy the deleted text
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- let you copy stuff to the clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
--maybe it let you past stuff from the clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])

--some kind of delete mode
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- create new tmux instance and let you change proyects
--vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- format code
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Quick fix navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

--open a regex search of the word where the cursor is
--and let you change it
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- who knows
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader>ml", "<cmd>CellularAutomaton game_of_life<CR>");

--make file executable?
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>m", "<CMD>MarkdownPreview<CR>")
vim.keymap.set("n", "<leader>mn", "<CMD>MarkdownPreviewStop<CR>")
