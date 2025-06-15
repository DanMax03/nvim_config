local opt = vim.opt

local g = vim.g


-- Number of spaces when using "<" and ">"
opt.shiftwidth = 3  -- why not?
opt.tabstop = 3  -- amount of spaces for 1 tab
opt.expandtab = true  -- no tabs when tab
opt.smartindent = true

g.go_recommended_style = false
