local v = vim.opt
-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

v.clipboard = "unnamedplus" -- Remove so we can to Ctrl - R 0 in insert mode

v.showtabline = 0
v.ignorecase = true
v.smartcase = true
v.smartindent = true
v.number = true
v.relativenumber = true
v.cursorline = true
v.signcolumn = "yes"

v.tabstop = 2 -- insert 2 spaces for a tab
v.shiftwidth = 2 -- the number of spaces inserted for each indentation
v.autoindent = true
v.smartindent = true
v.expandtab = true
v.swapfile = false

v.wrap = true -- display lines as one long line
v.updatetime = 100 -- faster completion (4000ms default)

v.termguicolors = true

v.fileformat = "unix"

-- vim.cmd("colorscheme habamax")
vim.cmd("colorscheme slate")
