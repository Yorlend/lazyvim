-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Set how many columns a tab character counts for on the screen
vim.opt.tabstop = 4
-- Set the number of spaces used for each step of indentation
vim.opt.shiftwidth = 4
-- TAB key inserts an actual tab character, not spaces
vim.opt.expandtab = false
-- Automatic indentation
vim.opt.smartindent = true

vim.opt.list = true

-- Define the characters to use for different whitespace types
vim.opt.listchars = {
	eol = "¬", -- Character at the end of the line
	tab = "» ", -- Character for a tab followed by a space
	trail = "•", -- Character for trailing spaces
	space = "·", -- Character for regular spaces (optional, can be very noisy)
	nbsp = "%", -- Character for non-breaking spaces
}

-- Disable autoformat on save globally
vim.g.autoformat = false
