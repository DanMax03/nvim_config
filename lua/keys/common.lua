local map = vim.keymap.set

local g = vim.g


-- Setting the map leaders
g.mapleader = " "
g.maplocalleader = "\\"

-- Mappings for copying to the system clipboard
map("n", "<leader>y", "\"+y")
map("v", "<leader>y", "\"+y")
map("n", "<leader>Y", "\"+Y")

-- Mappings for moving between splits
map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
map("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Resize split up" })
map("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Resize split down" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize split left" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize split right" })

