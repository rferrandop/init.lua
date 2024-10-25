vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.clipboard = "unnamedplus"

opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true

opt.wrap = false
opt.number = true

opt.termguicolors = true

opt.swapfile = false
opt.backup = false

opt.updatetime = 50
