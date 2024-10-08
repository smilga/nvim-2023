local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = false })

vim.api.nvim_create_autocmd("ExitPre", {
	callback = function()
		vim.cmd(":NvimTreeClose")
	end,
})

require("set")
require("keys")
vim.g.mapleader = ","

vim.cmd("colorscheme duskfox")
