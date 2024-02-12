return {
	"gbprod/nord.nvim",
	name = "nord",
	lazy = false,
	priority = 1000,
	config = function()
		require("nord").setup({
			transparent = false,
			diff = { mode = "fg" },
		})
		vim.cmd.colorscheme("nord")
	end,
}
