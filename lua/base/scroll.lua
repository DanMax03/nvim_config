local opt = vim.opt


-- Cursor cannot go lower or higher than 10 rows 
-- from the bottom or top respectively
opt.scrolloff = 10
-- Same but about right or left
opt.sidescrolloff = 15
