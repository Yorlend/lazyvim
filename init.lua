-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- Set how many columns a tab character counts for on the screen
vim.opt.tabstop = 4
-- Set the number of spaces used for each step of indentation
vim.opt.shiftwidth = 4
-- TAB key inserts an actual tab character, not spaces
vim.opt.expandtab = false
-- Automatic indentation
vim.opt.smartindent = true
