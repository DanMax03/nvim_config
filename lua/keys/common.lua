local map = vim.keymap.set

local g = vim.g


-- Setting the map leaders
g.mapleader = " "
g.maplocalleader = "\\"

-- Mappings for copying to the system clipboard
map("n", "<leader>y", "\"+y")
map("v", "<leader>y", "\"+y")
map("n", "<leader>Y", "\"+Y")
