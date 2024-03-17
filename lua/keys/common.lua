local map = vim.keymap.set
-- Prefix for noremap, suffix for normal mode
local nmapn = function (key, command, description)
   map('n', key, command, { noremap = true, desc = description })
end


local g = vim.g


-- Setting the map leaders
g.mapleader = " "
g.maplocalleader = "\\"

-- Mappings for copying to the system clipboard
map("n", "<leader>y", "\"+y")
map("v", "<leader>y", "\"+y")
map("n", "<leader>Y", "\"+Y")

-- Mappings for moving between splits
nmapn("<C-h>", "<C-w>h", "Move to left split")
nmapn("<C-j>", "<C-w>j", "Move to below split")
nmapn("<C-k>", "<C-w>k", "Move to above split")
nmapn("<C-l>", "<C-w>l", "Move to right split")
nmapn("<C-Up>", "<cmd>resize -2<CR>", "Resize split up")
nmapn("<C-Down>", "<cmd>resize +2<CR>", "Resize split down")
nmapn("<C-Left>", "<cmd>vertical resize -2<CR>", "Resize split left")
nmapn("<C-Right>", "<cmd>vertical resize +2<CR>", "Resize split right")

-- Mappings for diagnostics
nmapn("<leader>e", vim.diagnostic.open_float, "Open diagnostic float")

