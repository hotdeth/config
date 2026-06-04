local opt = vim.opt

opt.termguicolors = true
opt.inccommand = "split"
opt.number = true
opt.relativenumber = true

vim.cmd([[let &t_ZH="\e[3m"]])
vim.cmd([[let &t_ZR="\e[23m"]])

vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
